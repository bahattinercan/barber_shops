// To parse this JSON data, do
//
//     final workTime = workTimeFromJson(jsonString);

import 'dart:convert';

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
}
