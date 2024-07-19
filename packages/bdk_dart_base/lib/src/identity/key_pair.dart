
import 'dart:typed_data';

/// A Key Pair, containing a secret and public key.
abstract class KeyPair {
  const KeyPair({required this.secretKey, required this.publicKey});

  final Uint8List secretKey;
  final PublicKey publicKey;
}

abstract class PublicKey {
  const PublicKey();

  // Get the public key bytes encoded with DER.
  Uint8List toDer();
}
