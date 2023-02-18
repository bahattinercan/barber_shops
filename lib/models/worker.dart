// To parse this JSON data, do
//
//     final worker = workerFromJson(jsonString);

import 'dart:convert';

List<Worker> workerListFromJson(String str) => List<Worker>.from(json.decode(str).map((x) => Worker.fromJson(x)));

String workerListToJson(List<Worker> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Worker workerFromJson(String str) => Worker.fromJson(json.decode(str));

String workerToJson(Worker data) => json.encode(data.toJson());

class Worker {
  Worker({
    this.id,
    this.userId,
    this.barberShopId,
    this.image,
  });

  int? id;
  int? userId;
  int? barberShopId;
  String? image;

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"],
        userId: json["user_id"],
        barberShopId: json["barber_shop_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "barber_shop_id": barberShopId,
        "image": image,
      };
}
