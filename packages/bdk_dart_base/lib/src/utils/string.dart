import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';

String strip0xHex(String hex) {
  if (hex.startsWith('0x')) {
    return hex.substring(2);
  }
  return hex;
}

Uint8List stringToU8a(String msg, {String? enc, bool useDartEncode = true}) {
  if (useDartEncode == false) {
    if (enc == 'hex') {
      msg = strip0xHex(msg);
      final List<int> hexRes = [];
      msg = msg.replaceAll(RegExp('[^a-z0-9]'), '');
      if (msg.length % 2 != 0) msg = '0$msg';
      for (int i = 0; i < msg.length; i += 2) {
        final cul = msg[i] + msg[i + 1];
        final result = int.parse(cul, radix: 16);
        hexRes.add(result);
      }
      return Uint8List.fromList(hexRes);
    } else {
      final List<int> noHexRes = [];
      for (int i = 0; i < msg.length; i++) {
        final c = msg.codeUnitAt(i);
        final hi = c >> 8;
        final lo = c & 0xff;
        if (hi > 0) {
          noHexRes.add(hi);
        }
        noHexRes.add(lo);
      }
      return Uint8List.fromList(noHexRes);
    }
  } else {
    return Uint8List.fromList(utf8.encode(msg));
  }
}

/// Converts the hexadecimal string, which can be prefixed with 0x,
/// to a byte sequence.
List<int> hexToBytes(String hexStr) {
  return hex.decode(strip0xHex(hexStr));
}
