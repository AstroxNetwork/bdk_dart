// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.11.1.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class Secp256k1IdentityExport {
  final Uint8List privateKeyHash;
  final Uint8List derEncodedPublicKey;

  const Secp256k1IdentityExport({
    required this.privateKeyHash,
    required this.derEncodedPublicKey,
  });

  @override
  int get hashCode => privateKeyHash.hashCode ^ derEncodedPublicKey.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Secp256k1IdentityExport &&
          runtimeType == other.runtimeType &&
          privateKeyHash == other.privateKeyHash &&
          derEncodedPublicKey == other.derEncodedPublicKey;
}
