import 'dart:convert';
import 'dart:developer';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/user.dart';
import 'package:barbers/models/work_time_static.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppManager {
  static final instance = AppManager._internal();
  AppManager._internal();
  static late User user;
  static late BarberShop shop;
  List<Service> services = [];

  List<WorkTimeStatic> workTimes = [
    WorkTimeStatic(available: true, hour: 0, minute: 00),
    WorkTimeStatic(available: true, hour: 0, minute: 30),
    WorkTimeStatic(available: true, hour: 1, minute: 00),
    WorkTimeStatic(available: true, hour: 1, minute: 30),
    WorkTimeStatic(available: true, hour: 2, minute: 00),
    WorkTimeStatic(available: true, hour: 2, minute: 30),
    WorkTimeStatic(available: true, hour: 3, minute: 00),
    WorkTimeStatic(available: true, hour: 3, minute: 30),
    WorkTimeStatic(available: true, hour: 4, minute: 00),
    WorkTimeStatic(available: true, hour: 4, minute: 30),
    WorkTimeStatic(available: true, hour: 5, minute: 00),
    WorkTimeStatic(available: true, hour: 5, minute: 30),
    WorkTimeStatic(available: true, hour: 6, minute: 00),
    WorkTimeStatic(available: true, hour: 6, minute: 30),
    WorkTimeStatic(available: true, hour: 7, minute: 00),
    WorkTimeStatic(available: true, hour: 7, minute: 30),
    WorkTimeStatic(available: true, hour: 8, minute: 00),
    WorkTimeStatic(available: true, hour: 8, minute: 30),
    WorkTimeStatic(available: true, hour: 9, minute: 00),
    WorkTimeStatic(available: true, hour: 9, minute: 30),
    WorkTimeStatic(available: true, hour: 10, minute: 00),
    WorkTimeStatic(available: true, hour: 10, minute: 30),
    WorkTimeStatic(available: true, hour: 11, minute: 00),
    WorkTimeStatic(available: true, hour: 11, minute: 30),
    WorkTimeStatic(available: true, hour: 12, minute: 00),
    WorkTimeStatic(available: true, hour: 12, minute: 30),
    WorkTimeStatic(available: true, hour: 13, minute: 00),
    WorkTimeStatic(available: true, hour: 13, minute: 30),
    WorkTimeStatic(available: true, hour: 14, minute: 00),
    WorkTimeStatic(available: true, hour: 14, minute: 30),
    WorkTimeStatic(available: true, hour: 15, minute: 00),
    WorkTimeStatic(available: true, hour: 15, minute: 30),
    WorkTimeStatic(available: true, hour: 16, minute: 00),
    WorkTimeStatic(available: true, hour: 16, minute: 30),
    WorkTimeStatic(available: true, hour: 17, minute: 00),
    WorkTimeStatic(available: true, hour: 17, minute: 30),
    WorkTimeStatic(available: true, hour: 18, minute: 00),
    WorkTimeStatic(available: true, hour: 18, minute: 30),
    WorkTimeStatic(available: true, hour: 19, minute: 00),
    WorkTimeStatic(available: true, hour: 19, minute: 30),
    WorkTimeStatic(available: true, hour: 20, minute: 00),
    WorkTimeStatic(available: true, hour: 20, minute: 30),
    WorkTimeStatic(available: true, hour: 21, minute: 00),
    WorkTimeStatic(available: true, hour: 21, minute: 30),
    WorkTimeStatic(available: true, hour: 22, minute: 00),
    WorkTimeStatic(available: true, hour: 22, minute: 30),
    WorkTimeStatic(available: true, hour: 23, minute: 00),
    WorkTimeStatic(available: true, hour: 23, minute: 30),
  ];

  static String stringToTitle(String title) {
    title = title.toUpperCase();
    String spacedWord = "";

    for (int i = 0; i < title.length; i++) {
      spacedWord += "${title[i]} ";
    }
    return spacedWord;
  }

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
      result.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return result.toString();
  }
}
