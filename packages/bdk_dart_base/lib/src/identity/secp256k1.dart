import 'dart:typed_data';

import 'package:bdk_dart_ffi/bdk_dart_ffi.dart';

import 'package:pointycastle/api.dart' as p_api;
import 'package:pointycastle/digests/sha256.dart';

import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

// ignore: implementation_imports
import 'package:pointycastle/src/utils.dart' as p_utils;

import '../utils/der.dart';
import '../utils/extensions.dart';
import '../utils/u8a.dart';
import 'key_pair.dart';

final secp256k1Params = ECCurve_secp256k1();

BigInt _bytesToUnsignedInt(Uint8List bytes) {
  return p_utils.decodeBigIntWithSign(1, bytes);
}

// final ECDomainParameters params = ECCurve_secp256k1();
final BigInt _halfCurveOrder = secp256k1Params.n >> 1;

class Secp256k1KeyPair extends KeyPair {
  const Secp256k1KeyPair({required super.publicKey, required super.secretKey});

  List<String> toJson() {
    return [publicKey.toDer().toHex(), secretKey.toHex()];
  }
}

class Secp256k1PublicKey implements PublicKey {
  Secp256k1PublicKey(this.rawKey);

  factory Secp256k1PublicKey.fromRaw(Uint8List rawKey) {
    return Secp256k1PublicKey(rawKey);
  }

  factory Secp256k1PublicKey.fromDer(Uint8List derKey) {
    return Secp256k1PublicKey(Secp256k1PublicKey.derDecode(derKey));
  }

  factory Secp256k1PublicKey.from(PublicKey key) {
    return Secp256k1PublicKey.fromDer(key.toDer());
  }

  final Uint8List rawKey;
  late final derKey = Secp256k1PublicKey.derEncode(rawKey);

  static Uint8List derEncode(Uint8List publicKey) {
    return bytesWrapDer(publicKey, oidSecp256k1);
  }

  static Uint8List derDecode(Uint8List publicKey) {
    return bytesUnwrapDer(publicKey, oidSecp256k1);
  }

  @override
  Uint8List toDer() => derKey;

  Uint8List toRaw() => rawKey;
}

Uint8List signSecp256k1(String message, Uint8List secretKey) {
  final blob = message.plainToU8a(useDartEncode: true);
  final digest = SHA256Digest();
  final signer = ECDSASigner(digest, HMac(digest, 64));
  final key = ECPrivateKey(_bytesToUnsignedInt(secretKey), secp256k1Params);

  signer.init(true, p_api.PrivateKeyParameter(key));
  ECSignature sig = signer.generateSignature(blob) as ECSignature;
  if (sig.s.compareTo(_halfCurveOrder) > 0) {
    final canonicalizedS = secp256k1Params.n - sig.s;
    sig = ECSignature(sig.r, canonicalizedS);
  }
  if (sig.r == sig.s) {
    return signSecp256k1(message, secretKey);
  }
  Uint8List rU8a = sig.r.toU8a();
  Uint8List sU8a = sig.s.toU8a();
  if (rU8a.length < 32) {
    rU8a = Uint8List.fromList([0, ...rU8a]);
  }
  if (sU8a.length < 32) {
    sU8a = Uint8List.fromList([0, ...sU8a]);
  }
  return u8aConcat([rU8a, sU8a]);
}

Future<Uint8List> signSecp256k1Async(Uint8List blob, Uint8List seed) async {
  final result = await secp256K1Sign(
    req: Secp256k1SignWithSeedReq(seed: seed, msg: blob),
  );
  return result.signature!;
}

Future<Uint8List> signSecp256k1Recoverable(
  Uint8List blob,
  Uint8List seed,
) async {
  final result = await secp256K1SignRecoverable(
    req: Secp256k1SignWithSeedReq(seed: seed, msg: blob),
  );
  return result.signature!;
}

Future<Uint8List> signSecp256k1WithRNG(Uint8List blob, Uint8List bytes) async {
  final result = await secp256K1SignWithRng(
    req: Secp256k1SignWithRngReq(privateBytes: bytes, msg: blob),
  );

  return result.signature!;
}

bool verifySecp256k1(
  String message,
  Uint8List signature,
  Secp256k1PublicKey publicKey,
) {
  final blob = message.plainToU8a(useDartEncode: true);
  final digest = SHA256Digest();
  final signer = ECDSASigner(digest, HMac(digest, 64));
  final sig = ECSignature(
    signature.sublist(0, 32).toBn(endian: Endian.big),
    signature.sublist(32).toBn(endian: Endian.big),
  );
  final kpub = secp256k1Params.curve.decodePoint(publicKey.toRaw())!;
  final pub = ECPublicKey(kpub, secp256k1Params);
  signer.init(false, p_api.PublicKeyParameter(pub));
  return signer.verifySignature(blob, sig);
}

bool verifySecp256k1Blob(
  Uint8List blob,
  Uint8List signature,
  Secp256k1PublicKey publicKey,
) {
  final digest = SHA256Digest();
  final signer = ECDSASigner(digest, HMac(digest, 64));
  final sig = ECSignature(
    signature.sublist(0, 32).toBn(endian: Endian.big),
    signature.sublist(32).toBn(endian: Endian.big),
  );
  final kpub = secp256k1Params.curve.decodePoint(publicKey.toRaw())!;
  final pub = ECPublicKey(kpub, secp256k1Params);
  signer.init(false, p_api.PublicKeyParameter(pub));
  return signer.verifySignature(blob, sig);
}

Future<Uint8List> recoverSecp256k1PubKey(
  Uint8List preHashedMessage,
  Uint8List signature,
) async {
  final result = await secp256K1Recover(
    req: Secp256k1RecoverReq(
      messagePreHashed: preHashedMessage,
      signatureBytes: signature,
    ),
  );
  return result;
}

Future<Uint8List> getECShareSecret(
  Uint8List privateKey,
  Uint8List rawPublicKey,
) async {
  final result = await secp256K1GetSharedSecret(
    req: Secp256k1ShareSecretReq(
      seed: privateKey,
      publicKeyRawBytes: rawPublicKey,
    ),
  );
  return result;
}
