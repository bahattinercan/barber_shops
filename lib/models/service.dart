// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

List<Service> serviceListFromJson(String str) => List<Service>.from(json.decode(str).map((x) => Service.fromJson(x)));

String serviceListToJson(List<Service> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    this.id,
    this.name,
    this.price,
    this.userId,
    this.barberShopId,
    this.image,
  });

  int? id;
  String? name;
  String? price;
  int? userId;
  int? barberShopId;
  String? image;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        userId: json["user_id"],
        barberShopId: json["barber_shop_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "user_id": userId,
        "barber_shop_id": barberShopId,
        "image": image,
      };
}
