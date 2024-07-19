import 'package:bdk_dart_base/bdk_dart_base.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void main() {
  ffiInit();
  btcWalletTests();
}

void btcWalletTests() {
  Future<BitcoinWallet> getWallet() async {
    final wallet = await BitcoinWallet.fromPhrase(
      (await Mnemonic.create(WordCount.words12)).asString(),
      addressType: AddressType.P2PKHTR,
      network: Network.testnet,
      passcode: '123456',
    );

    await wallet.selectSigner(0);
    await wallet.cacheAddress(100);
    // await wallet.sync();
    return wallet;
  }

  test('get address by seedphrase and index', () async {
    final phrase = (await Mnemonic.create(WordCount.words12)).asString();
    final address = await getAddressInfo(
      phrase: phrase,
      index: 0,
      passcode: '123',
    );
    print(address.address);
  }, skip: true);
}
