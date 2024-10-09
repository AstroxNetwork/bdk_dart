import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bdk_dart_ffi/bdk_dart_ffi.dart';

import '../identity/secp256k1.dart';
import '../utils/extensions.dart';
import '../utils/is.dart';
import '../utils/u8a.dart';
import 'bdk.dart';
import 'config.dart';
import 'wif.dart';

typedef PsbtSignature = Uint8List;

enum BitcoinNetwork {
  mainnet,
  testnet,
}

class ReceiverItem {
  const ReceiverItem({
    required this.address,
    required this.amount,
  });

  final String address;
  final int amount;
}

class ReceiverItemWithAddress {
  const ReceiverItemWithAddress({
    required this.address,
    required this.amount,
  });

  final Address address;
  final int amount;
}

class BTCDescriptor {
  const BTCDescriptor({
    required this.addressType,
    required this.descriptor,
    required this.network,
  });

  final AddressType addressType;
  final Descriptor descriptor;
  final Network network;
}

class PSBTDetail {
  const PSBTDetail({
    required this.inputs,
    required this.outputs,
    required this.fee,
    required this.feeRate,
    required this.size,
    required this.totalInputValue,
    required this.totalOutputValue,
    required this.txId,
    required this.psbt,
  });

  final String txId;
  final List<TxOutExt> inputs;
  final List<TxOutExt> outputs;
  final int fee;
  final double feeRate;
  final int size;
  final int totalInputValue;
  final int totalOutputValue;
  final PartiallySignedTransaction psbt;

  Map<String, dynamic> toJson() {
    return {
      'txId': txId,
      'inputs': inputs.map((e) => e.toJson()).toList(),
      'outputs': outputs.map((e) => e.toJson()).toList(),
      'fee': fee,
      'feeRate': feeRate,
      'size': size,
      'totalInputValue': totalInputValue,
      'totalOutputValue': totalOutputValue,
      'psbt': psbt.psbtBase64,
    };
  }
}

class TxOutExt {
  const TxOutExt({
    this.txId,
    required this.index,
    required this.address,
    required this.value,
    required this.isChange,
    required this.isMine,
  });

  final String? txId;
  final int index;
  final Address address;
  final int value;
  final bool isChange;
  final bool isMine;

  Map<String, dynamic> toJson() {
    return {
      'txId': txId,
      'index': index,
      'address': address.toString(),
      'value': value,
      'isChange': isChange,
      'isMine': isMine,
    };
  }
}

class UtxoHandlers {
  const UtxoHandlers({
    required this.ins,
    required this.nonIns,
    required this.txs,
  });

  final List<OutPointWithInscription> ins;
  final List<OutPointWithInscription> nonIns;
  final List<dynamic> txs;
}

const UTXO_DUST = 546;

class UnconfirmedBalance {
  UnconfirmedBalance({
    required this.mempoolSpendTxValue,
    required this.mempoolReceiveTxValue,
    required this.tooManyUnconfirmed,
  });

  BigInt mempoolSpendTxValue = BigInt.zero;
  BigInt mempoolReceiveTxValue = BigInt.zero;
  bool tooManyUnconfirmed = false;

  Map<String, dynamic> toJson() {
    return {
      'mempoolSpendTxValue': mempoolSpendTxValue,
      'mempoolReceiveTxValue': mempoolReceiveTxValue,
      'tooManyUnconfirmed': tooManyUnconfirmed,
    };
  }
}

class BitcoinBalance {
  BitcoinBalance._(this.balance);

  factory BitcoinBalance.fromJson(Map<String, dynamic> json) {
    final balance = Balance(
      immature: json['immature'],
      trustedPending: json['trustedPending'],
      untrustedPending: json['untrustedPending'],
      confirmed: json['confirmed'],
      spendable: json['spendable'],
      total: json['total'],
    );
    final unconfirmed = (json['unconfirmed'] as Map).cast<String, dynamic>();
    final unconfirmedBalance = UnconfirmedBalance(
      mempoolReceiveTxValue: unconfirmed['mempoolReceiveTxValue'],
      mempoolSpendTxValue: unconfirmed['mempoolSpendTxValue'],
      tooManyUnconfirmed: unconfirmed['tooManyUnconfirmed'],
    );
    final bitcoinBalance = BitcoinBalance._(balance);
    bitcoinBalance.setUnconfirmed(unconfirmedBalance);
    return bitcoinBalance;
  }

  final Balance balance;

  final UnconfirmedBalance _unconfirmedBalance = UnconfirmedBalance(
    mempoolReceiveTxValue: BigInt.zero,
    mempoolSpendTxValue: BigInt.zero,
    tooManyUnconfirmed: false,
  );

  void setMempoolSpendTxValue(BigInt value) {
    _unconfirmedBalance.mempoolSpendTxValue = value;
  }

  void setMempoolReceiveTxValue(BigInt value) {
    _unconfirmedBalance.mempoolReceiveTxValue = value;
  }

  void setTooManyUnconfirmed(bool value) {
    _unconfirmedBalance.tooManyUnconfirmed = value;
  }

  void setUnconfirmed(UnconfirmedBalance unconfirmedBalance) {
    setMempoolReceiveTxValue(unconfirmedBalance.mempoolReceiveTxValue);
    setMempoolSpendTxValue(unconfirmedBalance.mempoolSpendTxValue);
    setTooManyUnconfirmed(unconfirmedBalance.tooManyUnconfirmed);
  }

  Map<String, dynamic> toJson() {
    return {
      'immature': balance.immature,
      'trustedPending': balance.trustedPending,
      'untrustedPending': balance.untrustedPending,
      'confirmed': balance.confirmed,
      'spendable': balance.spendable,
      'unconfirmed': _unconfirmedBalance.toJson(),
      'total': balance.total,
    };
  }

  BigInt get total => balance.total;

  BigInt get spendable => balance.spendable;

  BigInt get confirmed => balance.confirmed;

  BigInt get untrustedPending => balance.untrustedPending;

  BigInt get trustedPending => balance.trustedPending;

  BigInt get immature => balance.immature;

  UnconfirmedBalance get unconfirmed => _unconfirmedBalance;
}

Future<AddressInfo> getAddressInfo({
  required String phrase,
  required int index,
  Network network = Network.bitcoin,
  AddressType addressType = AddressType.P2TR,
  String? passphrase,
  String? derivedPathPrefix,
}) async {
  final descriptors = await getDescriptors(
    mnemonic: phrase,
    index: index,
    network: network,
    addressType: addressType,
    passphrase: passphrase,
    derivedPathPrefix: derivedPathPrefix,
  );
  final descriptor = descriptors[KeychainKind.extern]!;
  return descriptor.descriptor.deriveAddressAt(index, network);
}

Future<AddressInfo> getAddressInfoFromWIF({
  required String wif,
  Network network = Network.bitcoin,
  AddressType addressType = AddressType.P2TR,
}) async {
  final descriptor = await importSingleWif(
    wif,
    addressType: addressType,
    network: network,
  );
  return descriptor.descriptor.deriveAddressAt(0, network);
}

Future<Map<KeychainKind, BTCDescriptor>> getDescriptors({
  required String mnemonic,
  int index = 0,
  AddressType addressType = AddressType.P2TR,
  Network network = Network.bitcoin,
  String? passphrase,
  String? derivedPathPrefix,
}) async {
  derivedPathPrefix ??= addressType.derivedPath.substring(0, 13);
  final mnemonicObj = await Mnemonic.fromString(mnemonic);
  DescriptorSecretKey secretKey = await DescriptorSecretKey.create(
    network: network,
    mnemonic: mnemonicObj,
    passphrase: passphrase,
  );
  secretKey = await secretKey.extend(
    await DerivationPath.create(path: derivedPathPrefix),
  );
  secretKey.derivedIndex = index;
  secretKey.derivedPathPrefix = derivedPathPrefix;
  final descriptors = <KeychainKind, BTCDescriptor>{};
  for (final e in KeychainKind.values) {
    final create = switch (addressType) {
      AddressType.P2PKHTR => Descriptor.newBip44TR,
      AddressType.P2TR => Descriptor.newBip86,
      AddressType.P2SH_P2WPKH => Descriptor.newBip49,
      AddressType.P2WPKH => Descriptor.newBip84,
      AddressType.P2PKH => Descriptor.newBip44,
    };
    final descriptor = await create(
      secretKey: secretKey,
      network: network,
      keychain: e,
    );
    descriptors[e] = BTCDescriptor(
      addressType: addressType,
      descriptor: descriptor,
      network: network,
    );
  }
  return descriptors;
}

Future<BTCDescriptor> importSingleWif(
  String wif, {
  AddressType addressType = AddressType.P2TR,
  Network network = Network.bitcoin,
}) async {
  final descriptor = await Descriptor.importSingleWif(
    wif: wif,
    addressType: addressType,
    network: network,
  );

  final sec = await DescriptorSecretKey.fromString(wif);

  descriptor.descriptorSecretKey = sec;

  return BTCDescriptor(
    addressType: addressType,
    descriptor: descriptor,
    network: network,
  );
}

enum WalletType { HD, Single }

class BitcoinWallet {
  BitcoinWallet({
    required this.wallet,
    required this.addressType,
    required this.descriptor,
    this.network = Network.bitcoin,
    WalletType walletType = WalletType.HD,
  }) : _walletType = walletType;

  final Wallet wallet;
  final AddressType addressType;
  final BTCDescriptor descriptor;

  // late Blockchain blockchain;
  Network network;
  WalletType _walletType;

  late AddressInfo _selectedSigner;
  String? _publicKey;
  int? _index;

  String? getPublicKey() => _publicKey;

  final int coinbaseMaturity = 100;

  void setNetwork(Network net) {
    network = net;
  }

  void setWalletType(WalletType type) {
    _walletType = type;
  }

  WalletType getWalletType() {
    return _walletType;
  }

  static Future<BitcoinWallet> fromPhrase(
    String phrase, {
    Network network = Network.bitcoin,
    AddressType addressType = AddressType.P2TR,
    String? passphrase,
    String? derivedPathPrefix,
  }) async {
    final descriptors = await getDescriptors(
      mnemonic: phrase,
      network: network,
      addressType: addressType,
      passphrase: passphrase,
      derivedPathPrefix: derivedPathPrefix,
    );
    final descriptor = descriptors[KeychainKind.extern]!;
    final res = await Wallet.create(
      descriptor: descriptor.descriptor,
      changeDescriptor: descriptor.descriptor,
      network: network,
      databaseConfig: const DatabaseConfig.memory(),
    );
    final wallet = BitcoinWallet(
      wallet: res,
      addressType: descriptor.addressType,
      descriptor: descriptor,
      network: network,
      walletType: WalletType.HD,
    );
    // await wallet.blockchainInit(network: network);
    return wallet;
  }

  static Future<BitcoinWallet> fromWif(
    String wifOrHex, {
    Network network = Network.bitcoin,
    AddressType addressType = AddressType.P2TR,
    WalletType walletType = WalletType.HD,
  }) async {
    final WIF wif;
    final String mayBeWif;
    if (isHex(wifOrHex)) {
      wif = WIF.fromHex(wifOrHex.toU8a(), network: network);
      mayBeWif = wifEncoder.convert(wif);
    } else {
      wif = wifDecoder.convert(wifOrHex);
      mayBeWif = wifEncoder.convert(wif);
    }

    final descriptor = await importSingleWif(
      mayBeWif,
      network: network,
      addressType: addressType,
    );
    final res = await Wallet.create(
      descriptor: descriptor.descriptor,
      changeDescriptor: descriptor.descriptor,
      network: network,
      databaseConfig: const DatabaseConfig.memory(),
    );
    final wallet = BitcoinWallet(
      wallet: res,
      addressType: descriptor.addressType,
      descriptor: descriptor,
      network: network,
      walletType: WalletType.Single,
    );
    // await wallet.blockchainInit(network: network);
    return wallet;
  }

  Future<DescriptorSecretKey> getDescriptorSecretKey(int? index) async {
    final DescriptorSecretKey k;
    if (descriptor.descriptor.descriptorSecretKey?.derivedPathPrefix != null) {
      k = await descriptor.descriptor.descriptorSecretKey!.deriveIndex(index!);
    } else {
      k = descriptor.descriptor.descriptorSecretKey!;
    }
    return k;
  }

  // ====== Signer ======
  Future<AddressInfo> getSigner(int index) async {
    final k = await getDescriptorSecretKey(index);
    final kBytes = Uint8List.fromList(await k.secretBytes());
    _publicKey = await k.getPubFromBytes(kBytes);
    return wallet.getAddress(
      addressIndex: AddressIndex.reset(
        index: getWalletType() == WalletType.HD ? index : 0,
      ),
    );
  }

  Future<void> selectSigner(int index) async {
    _selectedSigner =
        await getSigner(getWalletType() == WalletType.HD ? index : 0);
    _index = getWalletType() == WalletType.HD ? index : 0;
  }

  int? currentIndex() {
    return _index;
  }

  AddressInfo currentSigner() {
    return _selectedSigner;
  }

  // Future<void> sync() {
  //   return wallet.sync(blockchain);
  // }

  Future<bool> cacheAddress(int cacheSize) {
    return wallet.cacheAddresses(cacheSize: cacheSize);
  }

  Future<TxBuilderResult> bumpFee({
    required String txid,
    required double feeRate,
  }) async {
    final builder = BumpFeeTxBuilder(txid: txid, feeRate: feeRate);
    builder.enableRbf();
    builder.keepChange(true); // don't know whether it works;
    // final leftAmount = unspent - networkFee;
    // builder.addRecipient(changeAddress, leftAmount);

    return builder.finish(wallet);
  }

  /// Sign a transaction with all the wallet’s signers, in the order specified by every signer’s SignerOrdering
  ///
  /// Note that it can’t be guaranteed that every signers will follow the options, but the “software signers” (WIF keys and xprv) defined in this library will.
  Future<TxBuilderResult> sign(TxBuilderResult buildResult) async {
    try {
      final sbt = await wallet.sign(psbt: buildResult.psbt);
      return TxBuilderResult(
        psbt: sbt,
        txDetails: buildResult.txDetails,
        signed: true,
      );
    } on AnyhowException catch (e) {
      throw e.message;
    }
  }

  Future<String> signPsbt(
    String psbtHex, {
    SignOptions options = defaultSignOptions,
  }) {
    return wallet.signPsbt(psbtHex, options: options);
  }

  Future<List<String>> signPsbts(
    List<String> psbtHexs, {
    SignOptions options = defaultSignOptions,
  }) async {
    try {
      return await Future.wait(
        psbtHexs.map((hex) => signPsbt(hex, options: options)),
      );
    } on AnyhowException catch (e) {
      throw e.message;
    }
  }

  Future<PSBTDetail> dumpPsbt(String psbtHex) async {
    final psbt = PartiallySignedTransaction.parse(psbtHex);
    final tx = await psbt.extractTx();

    final psbtInputs = await psbt.getPsbtInputs();

    final inputsExt = <TxOutExt>[];
    final txInputs = await tx.input();

    for (var i = 0; i < psbtInputs.length; i += 1) {
      final element = psbtInputs[i];
      final input = txInputs[i];
      final txId = input.previousOutput.txid;
      final addr = await Address.fromScript(element.scriptPubkey, network);

      inputsExt.add(
        TxOutExt(
          txId: txId,
          index: i,
          address: addr,
          value: element.value.toInt(),
          isMine: addr.address == currentSigner().address,
          isChange: false,
        ),
      );
    }
    final outputs = await tx.output();
    final outputsExt = <TxOutExt>[];

    for (var i = 0; i < outputs.length; i += 1) {
      final element = outputs[i];
      final addr = await Address.fromScript(element.scriptPubkey, network);

      outputsExt.add(
        TxOutExt(
          index: i,
          address: addr,
          value: element.value.toInt(),
          isMine: addr.address == currentSigner().address,
          isChange: i == outputs.length - 1 ? true : false,
        ),
      );
    }

    final size = Uint8List.fromList(await tx.serialize()).length;
    final feePaid = await psbt.feeAmount();
    final feeRate = (await psbt.feeRate())!.asSatPerVb();
    final txId = (await tx.txid()).toString();

    return PSBTDetail(
      txId: txId,
      inputs: inputsExt,
      outputs: outputsExt,
      fee: feePaid!,
      feeRate: feeRate,
      size: size,
      totalInputValue: inputsExt.fold(0, (v, i) => i.value + v),
      totalOutputValue: outputsExt.fold(0, (v, i) => i.value + v),
      psbt: psbt,
    );
  }

  Future<String> signMessage(
    String message, {
    bool toBase64 = true,
    bool useBip322 = false,
  }) async {
    try {
      final k = await getDescriptorSecretKey(currentIndex());
      final kBytes = Uint8List.fromList(await k.secretBytes());
      if (!useBip322) {
        final res = await signSecp256k1WithRNG(
          wallet.messageHandler(message),
          kBytes,
        );

        /// move v to the top, and plus 27
        final v = res.sublist(64, 65);
        v[0] = v[0] + 27;
        // regroup the signature
        final msgSig = u8aConcat([v, res.sublist(0, 64)]);
        if (toBase64) {
          return base64Encode(msgSig);
        }
        return msgSig.toHex();
      } else {
        final res = switch (addressType) {
          AddressType.P2TR ||
          AddressType.P2PKHTR =>
            await Api.bip322SignTaproot(
              secret: kBytes,
              message: message,
            ),
          _ => await Api.bip322SignSegwit(
              secret: kBytes,
              message: message,
            ),
        };
        if (toBase64) {
          return res;
        } else {
          return base64Decode(res).toHex();
        }
      }
    } on AnyhowException catch (e) {
      throw e.message;
    }
  }
}
