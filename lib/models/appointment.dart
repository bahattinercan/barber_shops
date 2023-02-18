// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

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
  });

  int? id;
  String? price;
  int? userId;
  int? barberShopId;
  List<int>? services;
  DateTime? time;
  int? workerId;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        price: json["price"],
        userId: json["user_id"],
        barberShopId: json["barber_shop_id"],
        services: json["services"] == null ? [] : List<int>.from(json["services"]!.map((x) => x)),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        workerId: json["worker_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "user_id": userId,
        "barber_shop_id": barberShopId,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "time": time?.toIso8601String(),
        "worker_id": workerId,
      };
}
