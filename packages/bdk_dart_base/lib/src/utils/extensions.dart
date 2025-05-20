import 'dart:typed_data';

import 'bn.dart' as bn_util;
import 'hex.dart' as hex_util;
import 'is.dart' as is_util;
import 'string.dart' as string_util;
import 'u8a.dart' as u8a_util;

extension BdkStringExtension on String {
  bool isHex({int bits = -1, bool ignoreLength = false}) {
    return is_util.isHex(this, bits: bits, ignoreLength: ignoreLength);
  }

  Uint8List toU8a({int bitLength = -1}) {
    return hex_util.hexToU8a(this, bitLength);
  }

  Uint8List plainToU8a({String? enc, bool useDartEncode = false}) =>
      string_util.stringToU8a(this, enc: enc, useDartEncode: useDartEncode);

}

extension BdkU8aExtension on Uint8List {
  String toHex({bool include0x = false}) =>
      u8a_util.u8aToHex(this, include0x: include0x);

  BigInt toBn({Endian endian = Endian.little}) =>
      u8a_util.u8aToBn(this, endian: endian);
}

extension BdkBnExtension on BigInt {
  BigInt toBn() => bn_util.bnToBn(this);

  String toHex({
    int bitLength = -1,
    Endian endian = Endian.big,
    bool isNegative = false,
    bool include0x = false,
  }) =>
      bn_util.bnToHex(
        this,
        bitLength: bitLength,
        endian: endian,
        isNegative: isNegative,
        include0x: include0x,
      );

  Uint8List toU8a({
    int bitLength = -1,
    Endian endian = Endian.big,
    bool isNegative = false,
  }) =>
      bn_util.bnToU8a(
        this,
        bitLength: bitLength,
        endian: endian,
        isNegative: isNegative,
      );

  BigInt bitNot({int? bitLength}) => bn_util.bitnot(this, bitLength: bitLength);
}
