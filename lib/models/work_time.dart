// To parse this JSON data, do
//
//     final workTime = workTimeFromJson(jsonString);

import 'dart:convert';

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
  });

  int? id;
  int? barberShopId;
  int? workerId;
  int? startTime;
  int? endTime;
  List<int>? breakStart;
  List<int>? breakEnd;

  factory WorkTime.fromJson(Map<String, dynamic> json) => WorkTime(
        id: json["id"],
        barberShopId: json["barber_shop_id"],
        workerId: json["worker_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        breakStart: json["break_start"] == null ? [] : List<int>.from(json["break_start"]!.map((x) => x)),
        breakEnd: json["break_end"] == null ? [] : List<int>.from(json["break_end"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "barber_shop_id": barberShopId,
        "worker_id": workerId,
        "start_time": startTime,
        "end_time": endTime,
        "break_start": breakStart == null ? [] : List<dynamic>.from(breakStart!.map((x) => x)),
        "break_end": breakEnd == null ? [] : List<dynamic>.from(breakEnd!.map((x) => x)),
      };
}
