import 'dart:typed_data';

import 'hex.dart';
import 'is.dart';
import 'number.dart';
import 'string.dart';

Uint8List convertString(String str, {bool useDartEncode = true}) {
  return isHex(str)
      ? hexToU8a(str)
      : stringToU8a(str, useDartEncode: useDartEncode);
}

Uint8List convertArray(List<int> arr) {
  return Uint8List.fromList(arr);
}

Uint8List u8aToU8a(dynamic value, {bool useDartEncode = true}) {
  if (value is ByteBuffer) {
    return value.asUint8List();
  } else if (value is Uint8List) {
    return value;
  } else if (value is String) {
    return convertString(value, useDartEncode: useDartEncode);
  } else if (value is List<int> && value.isNotEmpty) {
    return convertArray(value);
  } else {
    return Uint8List.fromList([]);
  }
}

Uint8List u8aConcat(List<dynamic> list) {
  final u8as = List<Uint8List>.generate(
    list.length,
    (index) => Uint8List.fromList([]),
  );

  for (int i = 0; i < list.length; i += 1) {
    u8as[i] = u8aToU8a(list[i]);
  }

  final expandedList = u8as.expand((element) => element).toList();
  final result = Uint8List.fromList(expandedList);
  return result;
}

BigInt u8aToBn(
  Uint8List u8a, {
  Endian endian = Endian.little,
  bool isNegative = false,
}) {
  return hexToBn(u8aToHex(u8a), endian: endian, isNegative: isNegative);
}

String u8aToHex(Uint8List u8a, {bool include0x = true}) {
  return bytesToHex(u8a, include0x: include0x);
}
