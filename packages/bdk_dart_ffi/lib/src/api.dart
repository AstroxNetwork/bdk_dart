// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.1.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import 'bdk/blockchain.dart';
import 'bdk/types.dart';
import 'bdk/wallet.dart';
import 'frb_generated.dart';
import 'lib.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'secp256k1.dart';
import 'types.dart';

// These functions are ignored because they are not marked as `pub`: `descriptor_secret_config`
// These types are ignored because they are not used by any `pub` functions: `RUNTIME`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `deref`, `initialize`

/// --------------------
/// WIF
/// --------------------
/// hex_bytes_to_wif
Future<String> hexBytesToWif({required String hex, required Network network}) =>
    BdkDart.instance.api.crateApiHexBytesToWif(hex: hex, network: network);

/// ---------------------
/// secp256k1
/// ---------------------
Future<Secp256k1IdentityExport> secp256K1FromSeed(
        {required Secp256k1FromSeedReq req}) =>
    BdkDart.instance.api.crateApiSecp256K1FromSeed(req: req);

Future<SignatureFFI> secp256K1Sign({required Secp256k1SignWithSeedReq req}) =>
    BdkDart.instance.api.crateApiSecp256K1Sign(req: req);

Future<SignatureFFI> secp256K1SignWithRng(
        {required Secp256k1SignWithRngReq req}) =>
    BdkDart.instance.api.crateApiSecp256K1SignWithRng(req: req);

Future<SignatureFFI> secp256K1SignRecoverable(
        {required Secp256k1SignWithSeedReq req}) =>
    BdkDart.instance.api.crateApiSecp256K1SignRecoverable(req: req);

Future<bool> secp256K1Verify({required Secp256k1VerifyReq req}) =>
    BdkDart.instance.api.crateApiSecp256K1Verify(req: req);

Future<Uint8List> secp256K1GetSharedSecret(
        {required Secp256k1ShareSecretReq req}) =>
    BdkDart.instance.api.crateApiSecp256K1GetSharedSecret(req: req);

Future<Uint8List> secp256K1Recover({required Secp256k1RecoverReq req}) =>
    BdkDart.instance.api.crateApiSecp256K1Recover(req: req);

// Rust type: RustOpaqueMoi<BdkDescriptor>
abstract class BdkDescriptor implements RustOpaqueInterface {}

// Rust type: RustOpaqueMoi<BlockchainInstance>
abstract class BlockchainInstance implements RustOpaqueInterface {}

class Api {
  const Api();

  static Future<String> addressFromScript(
          {required Script script, required Network network}) =>
      BdkDart.instance.api
          .crateApiApiAddressFromScript(script: script, network: network);

  static Future<Network> addressNetwork({required String address}) =>
      BdkDart.instance.api.crateApiApiAddressNetwork(address: address);

  static Future<Script> addressToScriptPubkey({required String address}) =>
      BdkDart.instance.api.crateApiApiAddressToScriptPubkey(address: address);

  static Future<String> asPublic({required String secret}) =>
      BdkDart.instance.api.crateApiApiAsPublic(secret: secret);

  static Future<Uint8List> asSecretBytes({required String secret}) =>
      BdkDart.instance.api.crateApiApiAsSecretBytes(secret: secret);

  static Future<String> asString({required BdkDescriptor descriptor}) =>
      BdkDart.instance.api.crateApiApiAsString(descriptor: descriptor);

  static Future<String> asStringPrivate({required BdkDescriptor descriptor}) =>
      BdkDart.instance.api.crateApiApiAsStringPrivate(descriptor: descriptor);

  static Future<String> bip322SignSegwit(
          {required List<int> secret, required String message}) =>
      BdkDart.instance.api
          .crateApiApiBip322SignSegwit(secret: secret, message: message);

  static Future<String> bip322SignTaproot(
          {required List<int> secret, required String message}) =>
      BdkDart.instance.api
          .crateApiApiBip322SignTaproot(secret: secret, message: message);

  static Future<String> broadcast(
          {required String tx, required BlockchainInstance blockchain}) =>
      BdkDart.instance.api.crateApiApiBroadcast(tx: tx, blockchain: blockchain);

  static Future<BdkTxBuilderResult> bumpFeeTxBuilderFinish(
          {required String txid,
          required double feeRate,
          String? allowShrinking,
          required WalletInstance wallet,
          required bool enableRbf,
          required bool keepChange,
          int? nSequence}) =>
      BdkDart.instance.api.crateApiApiBumpFeeTxBuilderFinish(
          txid: txid,
          feeRate: feeRate,
          allowShrinking: allowShrinking,
          wallet: wallet,
          enableRbf: enableRbf,
          keepChange: keepChange,
          nSequence: nSequence);

  static Future<bool> cacheAddress(
          {required WalletInstance wallet, required int cacheSize}) =>
      BdkDart.instance.api
          .crateApiApiCacheAddress(wallet: wallet, cacheSize: cacheSize);

  static Future<String> combinePsbt(
          {required String psbtStr, required String other}) =>
      BdkDart.instance.api
          .crateApiApiCombinePsbt(psbtStr: psbtStr, other: other);

  static Future<String> createAddress({required String address}) =>
      BdkDart.instance.api.crateApiApiCreateAddress(address: address);

  static Future<BlockchainInstance> createBlockchain(
          {required BlockchainConfig config}) =>
      BdkDart.instance.api.crateApiApiCreateBlockchain(config: config);

  static Future<String> createDerivationPath({required String path}) =>
      BdkDart.instance.api.crateApiApiCreateDerivationPath(path: path);

  static Future<String> createDerivedDescriptorSecret(
          {required Network network,
          required String mnemonic,
          required String path,
          String? password}) =>
      BdkDart.instance.api.crateApiApiCreateDerivedDescriptorSecret(
          network: network, mnemonic: mnemonic, path: path, password: password);

  static Future<BdkDescriptor> createDescriptor(
          {required String descriptor, required Network network}) =>
      BdkDart.instance.api.crateApiApiCreateDescriptor(
          descriptor: descriptor, network: network);

  static Future<String> createDescriptorPublic(
          {String? xpub, required String path, required bool derive}) =>
      BdkDart.instance.api.crateApiApiCreateDescriptorPublic(
          xpub: xpub, path: path, derive: derive);

  static Future<String> createDescriptorSecret(
          {required Network network,
          required String mnemonic,
          String? password}) =>
      BdkDart.instance.api.crateApiApiCreateDescriptorSecret(
          network: network, mnemonic: mnemonic, password: password);

  static Future<Script> createScript({required List<int> rawOutputScript}) =>
      BdkDart.instance.api
          .crateApiApiCreateScript(rawOutputScript: rawOutputScript);

  static Future<String> createTransaction({required List<int> tx}) =>
      BdkDart.instance.api.crateApiApiCreateTransaction(tx: tx);

  static Future<WalletInstance> createWallet(
          {required BdkDescriptor descriptor,
          BdkDescriptor? changeDescriptor,
          required Network network,
          required DatabaseConfig databaseConfig}) =>
      BdkDart.instance.api.crateApiApiCreateWallet(
          descriptor: descriptor,
          changeDescriptor: changeDescriptor,
          network: network,
          databaseConfig: databaseConfig);

  static Future<AddressInfo> deriveAddressAt(
          {required BdkDescriptor descriptor,
          required int index,
          required Network network}) =>
      BdkDart.instance.api.crateApiApiDeriveAddressAt(
          descriptor: descriptor, index: index, network: network);

  static Future<String> deriveDescriptorSecret(
          {required String secret, required String path}) =>
      BdkDart.instance.api
          .crateApiApiDeriveDescriptorSecret(secret: secret, path: path);

  static Future<String> descriptorPublicFromString(
          {required String publicKey}) =>
      BdkDart.instance.api
          .crateApiApiDescriptorPublicFromString(publicKey: publicKey);

  static Future<String> descriptorSecretFromString({required String secret}) =>
      BdkDart.instance.api
          .crateApiApiDescriptorSecretFromString(secret: secret);

  static Future<double> estimateFee(
          {required BigInt target, required BlockchainInstance blockchain}) =>
      BdkDart.instance.api
          .crateApiApiEstimateFee(target: target, blockchain: blockchain);

  static Future<String> extendDescriptorSecret(
          {required String secret, required String path}) =>
      BdkDart.instance.api
          .crateApiApiExtendDescriptorSecret(secret: secret, path: path);

  static Future<String> extractTx({required String psbtStr}) =>
      BdkDart.instance.api.crateApiApiExtractTx(psbtStr: psbtStr);

  static Future<String> generateSeedFromEntropy({required List<int> entropy}) =>
      BdkDart.instance.api.crateApiApiGenerateSeedFromEntropy(entropy: entropy);

  static Future<String> generateSeedFromString({required String mnemonic}) =>
      BdkDart.instance.api
          .crateApiApiGenerateSeedFromString(mnemonic: mnemonic);

  static Future<String> generateSeedFromWordCount(
          {required WordCount wordCount}) =>
      BdkDart.instance.api
          .crateApiApiGenerateSeedFromWordCount(wordCount: wordCount);

  static Future<AddressInfo> getAddress(
          {required WalletInstance wallet,
          required AddressIndex addressIndex}) =>
      BdkDart.instance.api
          .crateApiApiGetAddress(wallet: wallet, addressIndex: addressIndex);

  static Future<String> getAddressType({required String address}) =>
      BdkDart.instance.api.crateApiApiGetAddressType(address: address);

  static Future<Balance> getBalance({required WalletInstance wallet}) =>
      BdkDart.instance.api.crateApiApiGetBalance(wallet: wallet);

  static Future<String> getBlockchainHash(
          {required int blockchainHeight,
          required BlockchainInstance blockchain}) =>
      BdkDart.instance.api.crateApiApiGetBlockchainHash(
          blockchainHeight: blockchainHeight, blockchain: blockchain);

  static Future<int> getHeight({required BlockchainInstance blockchain}) =>
      BdkDart.instance.api.crateApiApiGetHeight(blockchain: blockchain);

  static Future<List<TxOut>> getInputs({required String psbtStr}) =>
      BdkDart.instance.api.crateApiApiGetInputs(psbtStr: psbtStr);

  static Future<AddressInfo> getInternalAddress(
          {required WalletInstance wallet,
          required AddressIndex addressIndex}) =>
      BdkDart.instance.api.crateApiApiGetInternalAddress(
          wallet: wallet, addressIndex: addressIndex);

  static Future<String> getPubFromSecretBytes({required List<int> bytes}) =>
      BdkDart.instance.api.crateApiApiGetPubFromSecretBytes(bytes: bytes);

  static Future<List<TransactionDetails>> getTransactions(
          {required WalletInstance wallet, required bool includeRaw}) =>
      BdkDart.instance.api
          .crateApiApiGetTransactions(wallet: wallet, includeRaw: includeRaw);

  static Future<String> getTx(
          {required String tx, required BlockchainInstance blockchain}) =>
      BdkDart.instance.api.crateApiApiGetTx(tx: tx, blockchain: blockchain);

  static Future<BdkDescriptor> importSingleWif(
          {required String wif,
          required String addressType,
          required Network network}) =>
      BdkDart.instance.api.crateApiApiImportSingleWif(
          wif: wif, addressType: addressType, network: network);

  static Future<List<TxIn>> input({required String tx}) =>
      BdkDart.instance.api.crateApiApiInput(tx: tx);

  static Future<bool> isCoinBase({required String tx}) =>
      BdkDart.instance.api.crateApiApiIsCoinBase(tx: tx);

  static Future<bool> isExplicitlyRbf({required String tx}) =>
      BdkDart.instance.api.crateApiApiIsExplicitlyRbf(tx: tx);

  static Future<bool> isLockTimeEnabled({required String tx}) =>
      BdkDart.instance.api.crateApiApiIsLockTimeEnabled(tx: tx);

  static Future<String> jsonSerialize({required String psbtStr}) =>
      BdkDart.instance.api.crateApiApiJsonSerialize(psbtStr: psbtStr);

  static Future<List<LocalUtxo>> listUnspent(
          {required WalletInstance wallet}) =>
      BdkDart.instance.api.crateApiApiListUnspent(wallet: wallet);

  static Future<List<LocalUtxo>> listUnspentOutputs(
          {required WalletInstance wallet}) =>
      BdkDart.instance.api.crateApiApiListUnspentOutputs(wallet: wallet);

  static Future<int> lockTime({required String tx}) =>
      BdkDart.instance.api.crateApiApiLockTime(tx: tx);

  static Future<String> masterFinterprint({required String xpub}) =>
      BdkDart.instance.api.crateApiApiMasterFinterprint(xpub: xpub);

  static Future<BdkDescriptor> newBip44Descriptor(
          {required KeychainKind keyChainKind,
          required String secretKey,
          required Network network}) =>
      BdkDart.instance.api.crateApiApiNewBip44Descriptor(
          keyChainKind: keyChainKind, secretKey: secretKey, network: network);

  static Future<BdkDescriptor> newBip44Public(
          {required KeychainKind keyChainKind,
          required String publicKey,
          required Network network,
          required String fingerprint}) =>
      BdkDart.instance.api.crateApiApiNewBip44Public(
          keyChainKind: keyChainKind,
          publicKey: publicKey,
          network: network,
          fingerprint: fingerprint);

  static Future<BdkDescriptor> newBip44TrDescriptor(
          {required KeychainKind keyChainKind,
          required String secretKey,
          required Network network}) =>
      BdkDart.instance.api.crateApiApiNewBip44TrDescriptor(
          keyChainKind: keyChainKind, secretKey: secretKey, network: network);

  static Future<BdkDescriptor> newBip44TrPublic(
          {required KeychainKind keyChainKind,
          required String publicKey,
          required Network network,
          required String fingerprint}) =>
      BdkDart.instance.api.crateApiApiNewBip44TrPublic(
          keyChainKind: keyChainKind,
          publicKey: publicKey,
          network: network,
          fingerprint: fingerprint);

  static Future<BdkDescriptor> newBip49Descriptor(
          {required KeychainKind keyChainKind,
          required String secretKey,
          required Network network}) =>
      BdkDart.instance.api.crateApiApiNewBip49Descriptor(
          keyChainKind: keyChainKind, secretKey: secretKey, network: network);

  static Future<BdkDescriptor> newBip49Public(
          {required KeychainKind keyChainKind,
          required String publicKey,
          required Network network,
          required String fingerprint}) =>
      BdkDart.instance.api.crateApiApiNewBip49Public(
          keyChainKind: keyChainKind,
          publicKey: publicKey,
          network: network,
          fingerprint: fingerprint);

  static Future<BdkDescriptor> newBip84Descriptor(
          {required KeychainKind keyChainKind,
          required String secretKey,
          required Network network}) =>
      BdkDart.instance.api.crateApiApiNewBip84Descriptor(
          keyChainKind: keyChainKind, secretKey: secretKey, network: network);

  static Future<BdkDescriptor> newBip84Public(
          {required KeychainKind keyChainKind,
          required String publicKey,
          required Network network,
          required String fingerprint}) =>
      BdkDart.instance.api.crateApiApiNewBip84Public(
          keyChainKind: keyChainKind,
          publicKey: publicKey,
          network: network,
          fingerprint: fingerprint);

  static Future<BdkDescriptor> newBip86Descriptor(
          {required KeychainKind keyChainKind,
          required String secretKey,
          required Network network}) =>
      BdkDart.instance.api.crateApiApiNewBip86Descriptor(
          keyChainKind: keyChainKind, secretKey: secretKey, network: network);

  static Future<BdkDescriptor> newBip86Public(
          {required KeychainKind keyChainKind,
          required String publicKey,
          required Network network,
          required String fingerprint}) =>
      BdkDart.instance.api.crateApiApiNewBip86Public(
          keyChainKind: keyChainKind,
          publicKey: publicKey,
          network: network,
          fingerprint: fingerprint);

  static Future<List<TxOut>> output({required String tx}) =>
      BdkDart.instance.api.crateApiApiOutput(tx: tx);

  static Future<Payload> payload({required String address}) =>
      BdkDart.instance.api.crateApiApiPayload(address: address);

  static Future<BigInt?> psbtFeeAmount({required String psbtStr}) =>
      BdkDart.instance.api.crateApiApiPsbtFeeAmount(psbtStr: psbtStr);

  static Future<double?> psbtFeeRate({required String psbtStr}) =>
      BdkDart.instance.api.crateApiApiPsbtFeeRate(psbtStr: psbtStr);

  static Future<String> psbtTxid({required String psbtStr}) =>
      BdkDart.instance.api.crateApiApiPsbtTxid(psbtStr: psbtStr);

  static Future<String> serializePsbt({required String psbtStr}) =>
      BdkDart.instance.api.crateApiApiSerializePsbt(psbtStr: psbtStr);

  static Future<Uint8List> serializeTx({required String tx}) =>
      BdkDart.instance.api.crateApiApiSerializeTx(tx: tx);

  static Future<String?> sign(
          {required WalletInstance wallet,
          required String psbtStr,
          SignOptions? signOptions}) =>
      BdkDart.instance.api.crateApiApiSign(
          wallet: wallet, psbtStr: psbtStr, signOptions: signOptions);

  static Future<BigInt> size({required String tx}) =>
      BdkDart.instance.api.crateApiApiSize(tx: tx);

  static Future<String> toPublicString({required String xpub}) =>
      BdkDart.instance.api.crateApiApiToPublicString(xpub: xpub);

  static Future<BdkTxBuilderResult> txBuilderFinish(
          {required WalletInstance wallet,
          required List<ScriptAmount> recipients,
          required List<TxBytes> txs,
          required List<OutPoint> unspendable,
          required List<ForeignUtxo> foreignUtxos,
          required ChangeSpendPolicy changePolicy,
          required bool manuallySelectedOnly,
          double? feeRate,
          BigInt? feeAbsolute,
          required bool drainWallet,
          Script? drainTo,
          RbfValue? rbf,
          required List<int> data,
          bool? shuffleUtxo}) =>
      BdkDart.instance.api.crateApiApiTxBuilderFinish(
          wallet: wallet,
          recipients: recipients,
          txs: txs,
          unspendable: unspendable,
          foreignUtxos: foreignUtxos,
          changePolicy: changePolicy,
          manuallySelectedOnly: manuallySelectedOnly,
          feeRate: feeRate,
          feeAbsolute: feeAbsolute,
          drainWallet: drainWallet,
          drainTo: drainTo,
          rbf: rbf,
          data: data,
          shuffleUtxo: shuffleUtxo);

  static Future<BigInt> txCalFeeFinish(
          {required WalletInstance wallet,
          required List<ScriptAmount> recipients,
          required List<TxBytes> txs,
          required List<OutPoint> unspendable,
          required List<ForeignUtxo> foreignUtxos,
          required ChangeSpendPolicy changePolicy,
          required bool manuallySelectedOnly,
          double? feeRate,
          BigInt? feeAbsolute,
          required bool drainWallet,
          Script? drainTo,
          RbfValue? rbf,
          required List<int> data,
          bool? shuffleUtxo}) =>
      BdkDart.instance.api.crateApiApiTxCalFeeFinish(
          wallet: wallet,
          recipients: recipients,
          txs: txs,
          unspendable: unspendable,
          foreignUtxos: foreignUtxos,
          changePolicy: changePolicy,
          manuallySelectedOnly: manuallySelectedOnly,
          feeRate: feeRate,
          feeAbsolute: feeAbsolute,
          drainWallet: drainWallet,
          drainTo: drainTo,
          rbf: rbf,
          data: data,
          shuffleUtxo: shuffleUtxo);

  static Future<String> txTxid({required String tx}) =>
      BdkDart.instance.api.crateApiApiTxTxid(tx: tx);

  static Future<int> version({required String tx}) =>
      BdkDart.instance.api.crateApiApiVersion(tx: tx);

  static Future<BigInt> vsize({required String tx}) =>
      BdkDart.instance.api.crateApiApiVsize(tx: tx);

  static Future<Network> walletNetwork({required WalletInstance wallet}) =>
      BdkDart.instance.api.crateApiApiWalletNetwork(wallet: wallet);

  static Future<BigInt> weight({required String tx}) =>
      BdkDart.instance.api.crateApiApiWeight(tx: tx);

  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Api && runtimeType == other.runtimeType;
}
