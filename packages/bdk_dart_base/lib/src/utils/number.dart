import 'dart:typed_data';

import 'package:convert/convert.dart';

/// Converts the [bytes] given as a list of integers into a hexadecimal
/// representation.
///
/// If any of the bytes is outside of the range [0, 256], the method will throw.
/// The outcome of this function will prefix a 0 if it would otherwise not be
/// of even length. If [include0x] is set, it will prefix "0x" to the hexadecimal
/// representation.
String bytesToHex(List<int> bytes, {bool include0x = false}) {
  return (include0x ? '0x' : '') + hex.encode(bytes);
}

BigInt decodeBigInt(List<int> bytes, {Endian endian = Endian.little}) {
  BigInt result = BigInt.from(0);
  for (int i = 0; i < bytes.length; i++) {
    final newValue = BigInt.from(
      bytes[endian == Endian.little ? i : bytes.length - i - 1],
    );
    result += newValue << (8 * i);
  }
  return result;
}

Uint8List encodeBigInt(
  BigInt number, {
  Endian endian = Endian.little,
  int? bitLength,
}) {
  final bl = (bitLength != null) ? bitLength : number.bitLength;
  final int size = (bl + 7) >> 3;
  final result = Uint8List(size);

  for (int i = 0; i < size; i++) {
    result[endian == Endian.little ? i : size - i - 1] =
        (number & BigInt.from(0xff)).toInt();
    number = number >> 8;
  }
  return result;
}
