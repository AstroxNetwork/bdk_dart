import 'dart:math' as math;
import 'dart:typed_data';

import 'is.dart';
import 'number.dart';
import 'string.dart';

bool hexHasPrefix(String value) {
  return isHex(value, ignoreLength: true) && value.substring(0, 2) == '0x';
}

String hexStripPrefix(String value) {
  if (value.isEmpty) {
    return '';
  }
  if (hexHasPrefix(value)) {
    return value.substring(2);
  }
  final reg = RegExp(r'^[a-fA-F\d]+$');
  if (reg.hasMatch(value)) {
    return value;
  }
  throw ArgumentError.value(value);
}

BigInt hexToBn(
    dynamic value, {
      Endian endian = Endian.big,
      bool isNegative = false,
    }) {
  if (value == null) {
    return BigInt.from(0);
  }
  if (isNegative == false) {
    if (isHex(value)) {
      String sValue = value is num
          ? int.parse(value.toString(), radix: 10).toRadixString(16)
          : value;
      sValue = hexStripPrefix(sValue);
      if (endian == Endian.big) {
        return BigInt.parse(sValue.isEmpty ? '0' : sValue, radix: 16);
      } else {
        return decodeBigInt(hexToBytes(sValue.isEmpty ? '0' : sValue));
      }
    }
    final sValue = value is num
        ? int.parse(value.toString(), radix: 10).toRadixString(16)
        : value;
    if (endian == Endian.big) {
      return BigInt.parse(sValue, radix: 16);
    }
    return decodeBigInt(
      hexToBytes(
        hexStripPrefix(sValue) == '' ? '0' : hexStripPrefix(sValue),
      ),
    );
  } else {
    String hex = value is num
        ? int.parse(value.toString(), radix: 10).toRadixString(16)
        : hexStripPrefix(value);
    if (hex.length % 2 > 0) {
      hex = '0$hex';
    }
    hex = decodeBigInt(
      hexToBytes(hexStripPrefix(hex) == '' ? '0' : hexStripPrefix(hex)),
      endian: endian,
    ).toRadixString(16);
    BigInt bn = BigInt.parse(hex, radix: 16);

    final result = 0x80 &
    int.parse(hex.substring(0, 2 > hex.length ? hex.length : 2), radix: 16);
    if (result > 0) {
      BigInt some = BigInt.parse(
        bn.toRadixString(2).split('').map((i) {
          return '0' == i ? 1 : 0;
        }).join(),
        radix: 2,
      );
      some += BigInt.one;
      bn = -some;
    }
    return bn;
  }
}

/// [value] should be `0x` hex string.
Uint8List hexToU8a(String value, [int bitLength = -1]) {
  if (!isHex(value)) {
    throw ArgumentError.value(value, 'value', 'Not a valid hex string');
  }
  final newValue = hexStripPrefix(value);
  final valLength = newValue.length / 2;
  final bufLength = (bitLength == -1 ? valLength : bitLength / 8).ceil();
  final result = Uint8List(bufLength);
  final offset = math.max(0, bufLength - valLength).toInt();
  for (int index = 0; index < bufLength - offset; index++) {
    final subStart = index * 2;
    final subEnd =
    subStart + 2 <= newValue.length ? subStart + 2 : newValue.length;
    final arrIndex = index + offset;
    result[arrIndex] = int.parse(
      newValue.substring(subStart, subEnd),
      radix: 16,
    );
  }
  return result;
}
