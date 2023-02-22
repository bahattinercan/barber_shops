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
}
