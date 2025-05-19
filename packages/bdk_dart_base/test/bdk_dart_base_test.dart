import 'dart:typed_data';

import 'package:bdk_dart_base/bdk_dart_base.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

Future<BitcoinWallet> _getWallet({
  String? phrase,
  WordCount wordCount = WordCount.words12,
  AddressType addressType = AddressType.P2WPKH,
  Network network = Network.testnet,
  String derivedPathPrefix = "m/84'/0'/0'/9",
  String? passphrase,
  int index = 0,
}) async {
  final wallet = await BitcoinWallet.fromPhrase(
    phrase ?? (await Mnemonic.create(wordCount)).asString(),
    addressType: addressType,
    network: network,
    derivedPathPrefix: derivedPathPrefix,
    passphrase: passphrase,
  );
  await wallet.selectSigner(index);
  await wallet.cacheAddress(100);

  return wallet;
}

void main() {
  ffiInit();

  group('BitcoinWallet', () {
    test('currentSigner', () async {
      final wallet = await _getWallet();
      print('wallet.currentSigner() ${wallet.currentSigner().address}');
    });
  });

  group('getAddressInfo', () {
    test('get address by seedphrase and index', () async {
      final phrase = (await Mnemonic.create(WordCount.words12)).asString();
      final address = await getAddressInfo(
        phrase: phrase,
        index: 0,
        passphrase: '123',
      );
      print(address.address);
    });
  });

  group('WIF', () {
    const privateKey =
        'be7226a6b5a894da122f631d80d175b1c5cc93d2c16f8ebd8840a58eeb503080';

    test('encode', () async {
      // @formatter:off
      // dart format off
      final bytes = Uint8List.fromList([190, 114, 38, 166, 181, 168, 148, 218, 18, 47, 99, 29, 128, 209, 117, 177, 197, 204, 147, 210, 193, 111, 142, 189, 136, 64, 165, 142, 235, 80, 48, 128]);
      // dart format on
      // @formatter:on
      final wif = WIF.fromHex(bytes, network: Network.testnet);
      expect(wif.version, 0xef);
      expect(
        wif.privateKey.map((e) => e.toRadixString(16).padLeft(2, '0')).join(),
        privateKey,
      );
    });

    test('decode', () async {
      const wifString = 'cTxuMvXYFYxQrqogSUAPR1HzDRH7X7tSyd5ZX3dDYGswBYc3hpoW';
      final wif = WIF.fromString(wifString, network: Network.testnet);
      expect(wif.version, 0xef);
      expect(
        wif.privateKey.map((e) => e.toRadixString(16).padLeft(2, '0')).join(),
        privateKey,
      );
    });
  });
}
