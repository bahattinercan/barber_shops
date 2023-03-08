// To parse this JSON data, do
//
//     final workTime = workTimeFromJson(jsonString);

import 'dart:convert';

import 'package:barbers/utils/requester.dart';
import 'package:flutter/material.dart';

List<WorkTime> workTimeListFromJson(String str) =>
    List<WorkTime>.from(json.decode(str).map((x) => WorkTime.fromJson(x)));

String workTimeListToJson(List<WorkTime> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

WorkTime workTimeFromJson(String str) => WorkTime.fromJson(json.decode(str));

String workTimeToJson(WorkTime data) => json.encode(data.toJson());

class WorkTime {
  WorkTime({
    this.id,
    this.barberShopId,
    this.workerId,
    this.startTime,
    this.endTime,
    this.breakStart,
    this.breakEnd,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.startTimeOfDay,
    this.endTimeOfDay,
    this.breakStartTimeOfDay,
    this.breakEndTimeOfDay,
  });

  int? id;
  int? barberShopId;
  int? workerId;
  String? startTime;
  String? endTime;
  String? breakStart;
  String? breakEnd;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thursday;
  bool? friday;
  bool? saturday;
  bool? sunday;
  TimeOfDay? startTimeOfDay;
  TimeOfDay? endTimeOfDay;
  TimeOfDay? breakStartTimeOfDay;
  TimeOfDay? breakEndTimeOfDay;

  static String table = "work_times";

  static TimeOfDay getTimeOfDay(String time) {
    final data = time.split(".");
    return TimeOfDay(hour: int.parse(data[0]), minute: int.parse(data[1]));
  }

  factory WorkTime.fromJson(Map<String, dynamic> json) {
    getTimeOfDay(json["end_time"]);
    return WorkTime(
      id: json["id"],
      barberShopId: json["barber_shop_id"],
      workerId: json["worker_id"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      breakStart: json["break_start"],
      breakEnd: json["break_end"],
      monday: json["monday"],
      tuesday: json["tuesday"],
      wednesday: json["wednesday"],
      thursday: json["thursday"],
      friday: json["friday"],
      saturday: json["saturday"],
      sunday: json["sunday"],
      startTimeOfDay: getTimeOfDay(json["start_time"]),
      endTimeOfDay: getTimeOfDay(json["end_time"]),
      breakStartTimeOfDay: getTimeOfDay(json["break_start"]),
      breakEndTimeOfDay: getTimeOfDay(json["break_end"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "barber_shop_id": barberShopId,
        "worker_id": workerId,
        "start_time": startTime,
        "end_time": endTime,
        "break_start": breakStart,
        "break_end": breakEnd,
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "saturday": saturday,
        "sunday": sunday,
      };

  //#region requests

  static Future<WorkTime?> create({
    required int shopId,
    required int workerId,
    required String startTime,
    required String endTime,
    required String breakStart,
    required String breakEnd,
    required bool monday,
    required bool tuesday,
    required bool wednesday,
    required bool thursday,
    required bool friday,
    required bool saturday,
    required bool sunday,
  }) async {
    final result = await Requester.postReq(
        "/$table",
        workTimeToJson(WorkTime(
          barberShopId: shopId,
          workerId: workerId,
          startTime: startTime,
          endTime: endTime,
          breakStart: breakStart,
          breakEnd: breakEnd,
          monday: monday,
          tuesday: tuesday,
          wednesday: wednesday,
          thursday: thursday,
          friday: friday,
          saturday: saturday,
          sunday: sunday,
        )));
    if (Requester.isSuccess)
      return workTimeFromJson(result);
    else
      return null;
  }

  static Future<List<WorkTime>> getAll() async {
    final result = await Requester.getReq("/$table");
    if (Requester.isSuccess)
      return workTimeListFromJson(result);
    else
      return [];
  }

  static Future<WorkTime?> getBarber({required int workerId, required int shopId}) async {
    final result = await Requester.getReq("/$table/$workerId/$shopId");
    if (Requester.isSuccess)
      return workTimeFromJson(result);
    else
      return null;
  }

  static Future<WorkTime?> get({required int id}) async {
    final result = await Requester.getReq("/$table/$id");
    if (Requester.isSuccess)
      return workTimeFromJson(result);
    else
      return null;
  }

  static Future<WorkTime?> getData({required int id, required String column}) async {
    final result = await Requester.getReq("/$table/data/$id/$column");
    if (Requester.isSuccess)
      return workTimeFromJson(result);
    else
      return null;
  }

  static Future<bool> setData({
    required int id,
    required String column,
    required dynamic data,
  }) async {
    final result = await Requester.putReq(
      "/$table/data/$id/$column",
      jsonEncode({"data": data}),
    );
    return result;
  }

  static Future<bool> delete({required int id}) async {
    final result = await Requester.deleteReq("/$table/$id");
    return result;
  }

  //#endregion
}
