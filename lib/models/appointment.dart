// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

import 'package:barbers/utils/requester.dart';

List<Appointment> appointmentListFromJson(String str) =>
    List<Appointment>.from(json.decode(str).map((x) => Appointment.fromJson(x)));

String appointmentListtToJson(List<Appointment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  Appointment({
    this.id,
    this.price,
    this.userId,
    this.barberShopId,
    this.services,
    this.time,
    this.workerId,
    this.workerUid,
    this.customerName,
    this.customerPhone,
    this.barberName,
  });

  int? id;
  String? price;
  int? userId;
  int? barberShopId;
  List<int>? services;
  DateTime? time;
  int? workerId;
  int? workerUid;
  String? customerName;
  String? customerPhone;
  String? barberName;

  static String table = "appointments";

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        price: json["price"],
        userId: json["user_id"],
        barberShopId: json["barber_shop_id"],
        services: json["services"] == null ? [] : List<int>.from(json["services"]!.map((x) => x)),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        workerId: json["worker_id"],
        workerUid: json["worker_uid"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        barberName: json["barber_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "user_id": userId,
        "barber_shop_id": barberShopId,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "time": time?.toIso8601String(),
        "worker_id": workerId,
        "worker_uid": workerUid,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "barber_name": barberName,
      };

  //#region requests

  static Future<Appointment?> create({
    required String price,
    required int userId,
    required int barberShopId,
    required List<int> services,
    required DateTime time,
    required int workerId,
    required int workerUid,
  }) async {
    final result = await Requester.postReq(
        "/$table",
        appointmentToJson(Appointment(
          price: price,
          userId: userId,
          barberShopId: barberShopId,
          services: services,
          time: time,
          workerId: workerId,
          workerUid: workerUid,
        )));
    if (Requester.isSuccess) {
      return appointmentFromJson(result);
    } else {
      return null;
    }
  }

  static Future<List<Appointment>> getAll() async {
    final result = await Requester.getReq("/$table");
    if (Requester.isSuccess) {
      return appointmentListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<List<Appointment>> getShops({required int shopId}) async {
    final result = await Requester.getReq("/$table/shop/$shopId");
    if (Requester.isSuccess) {
      return appointmentListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<List<Appointment>> getWorkers({required int shopId, required int workerId}) async {
    final result = await Requester.getReq("/$table/worker/$workerId/$shopId");
    if (Requester.isSuccess) {
      return appointmentListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<List<Appointment>> getUserAppointments({required int userId}) async {
    final result = await Requester.getReq("/$table/my/$userId");
    if (Requester.isSuccess) {
      return appointmentListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<List<Appointment>> getTakenTimes({
    required int shopId,
    required int workerId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final result = await Requester.postReq(
      "/$table/taken_times/$shopId/$workerId",
      jsonEncode({"start_time": startTime.toIso8601String(), "end_time": endTime.toIso8601String()}),
    );
    if (Requester.isSuccess) {
      return appointmentListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<Appointment?> get({required int id}) async {
    final result = await Requester.getReq("/$table/$id");
    if (Requester.isSuccess) {
      return appointmentFromJson(result);
    } else {
      return null;
    }
  }

  static Future<Appointment?> getData({required int id, required String column}) async {
    final result = await Requester.getReq("/$table/data/$id/$column");
    if (Requester.isSuccess) {
      return appointmentFromJson(result);
    } else {
      return null;
    }
  }

  static Future<bool> setData({required int id, required String column, required dynamic data}) async {
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
