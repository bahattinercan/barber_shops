import 'dart:convert';
import 'package:barbers/models/user.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppManager {
  static final instance = AppManager._internal();
  AppManager._internal();
  static late User user;
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  DateFormat backendFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

  static Future bottomSheet(BuildContext context, Widget widget) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return widget;
      },
    );
  }

  Uint8List hexStringToUint8List(String hexString) {
    var result = Uint8List(hexString.length ~/ 2);
    for (var i = 0; i < hexString.length; i += 2) {
      var num = int.parse(hexString.substring(i, i + 2), radix: 16);
      result[i ~/ 2] = num;
    }
    return result;
  }

  String base64ToHexString(String base64) {
    var bytes = base64Decode(base64);
    return bytesToHex(bytes);
  }

  String bytesToHex(List<int> bytes) {
    var result = StringBuffer();
    for (var byte in bytes) {
      result.write('${byte.toRadixString(16).padLeft(2, '0')}');
    }
    return result.toString();
  }
}