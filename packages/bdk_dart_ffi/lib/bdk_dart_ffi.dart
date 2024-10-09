import 'src/bdk/types.dart' show Network, OutPoint;

export 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart'
    show AnyhowException, ExternalLibrary;

export 'src/api.dart';
export 'src/bdk/blockchain.dart';
export 'src/bdk/types.dart';
export 'src/bdk/wallet.dart';
export 'src/frb_generated.dart' show BdkDart;
export 'src/lib.dart';
export 'src/types.dart';

const _networkNameMap = <Network, Set<String>>{
  Network.bitcoin: {'livenet', 'mainnet'},
  Network.testnet: {'testnet'},
  Network.regtest: {'regtest'},
  Network.signet: {'signet'},
};

extension BdkDartFFIBitcoinNetworkExtension on Network {
  String get networkName => _networkNameMap[this]!.first;

  bool matches(String? name) => _networkNameMap[this]!.contains(name);
}

extension BdkDartFFIOutPointExtension on OutPoint {
  String get uniqueKey => '$txid:$vout';
}
