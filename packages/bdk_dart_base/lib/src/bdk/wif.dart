import 'dart:convert' show Converter;
import 'dart:typed_data' show Uint8List;

import 'package:base58check/base58check.dart';
import 'package:bdk_dart_ffi/bdk_dart_ffi.dart' show Network, hexBytesToWif;

final _bs58Check = Base58CheckCodec.bitcoin();

/// The canonical instance of [WIFEncoder].
const wifDecoder = WIFDecoder();

/// The canonical instance of [WIFDecoder].
class WIFDecoder extends Converter<String, WIF> {
  const WIFDecoder();

  /// Convert [String] to [WIF]
  @override
  WIF convert(String input, [int? version]) {
    final payload = _bs58Check.decode(input);
    if (version != null && payload.version != version) {
      throw ArgumentError('Invalid network version');
    }

    final buffer = Uint8List.fromList(payload.payload);

    // uncompressed
    if (buffer.lengthInBytes == 32) {
      return WIF(version: payload.version, privateKey: buffer.sublist(0));
    }

    // invalid length
    if (buffer.length != 33) {
      throw ArgumentError('Invalid WIF length');
    }

    // invalid compression flag
    if (buffer[32] != 0x01) {
      throw ArgumentError('Invalid compression flag');
    }

    // compressed
    return WIF(
      version: payload.version,
      privateKey: buffer.sublist(0, 32),
      compressed: true,
    );
  }
}

/// The canonical instance of [WIFEncoder].
const wifEncoder = WIFEncoder();

/// Encode [WIF] to [String]
class WIFEncoder extends Converter<WIF, String> {
  const WIFEncoder();

  /// Convert [WIF] to [String]
  @override
  String convert(WIF input) {
    if (input.privateKey.length != 32) {
      throw ArgumentError('Invalid privateKey length');
    }

    final result = Uint8List(input.compressed ? 33 : 32);
    result.setRange(0, 32, input.privateKey);
    // if is compressed, add compressed flag
    if (input.compressed) {
      result[32] = 0x01;
    }

    final payload = Base58CheckPayload(input.version, result);
    return _bs58Check.encode(payload);
  }
}

/// WIF
class WIF {
  const WIF({
    required this.version,
    required this.privateKey,
    this.compressed = false,
  });

  factory WIF.fromHex(Uint8List u8a, {Network network = Network.bitcoin}) {
    final version = network == Network.bitcoin ? 0x80 : 0xef;
    return WIF(version: version, privateKey: u8a);
  }

  factory WIF.fromString(String wif, {Network network = Network.bitcoin}) {
    final version = network == Network.bitcoin ? 0x80 : 0xef;
    return wifDecoder.convert(wif, version);
  }

  /// Version
  final int version;

  /// Private Key
  final Uint8List privateKey;

  /// Is Compressed WIF ?
  final bool compressed;

  static Future<String> hexToWif(
    String hex, {
    Network network = Network.bitcoin,
  }) {
    return hexBytesToWif(hex: hex, network: network);
  }

  @override
  bool operator ==(covariant WIF other) {
    return version == other.version &&
        privateKey.map((e) => e.toRadixString(16).padLeft(2, '0')).join() ==
            privateKey.map((e) => e.toRadixString(16).padLeft(2, '0')).join() &&
        compressed == other.compressed;
  }

  @override
  int get hashCode => Object.hashAll([version, privateKey, compressed]);

  @override
  String toString() {
    final str = [
      '"version": "$version"',
      '"privateKey": "${privateKey.map((e) => e.toRadixString(16).padLeft(2, '0')).join()}"',
      '"compressed": ${compressed.toString()}',
    ];

    return "{${str.join(",")}}";
  }
}
