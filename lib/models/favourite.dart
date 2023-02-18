// To parse this JSON data, do
//
//     final favourite = favouriteFromJson(jsonString);

import 'dart:convert';

List<Favourite> favouriteListFromJson(String str) =>
    List<Favourite>.from(json.decode(str).map((x) => Favourite.fromJson(x)));

String favouriteListToJson(List<Favourite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Favourite favouriteFromJson(String str) => Favourite.fromJson(json.decode(str));

String favouriteToJson(Favourite data) => json.encode(data.toJson());

class Favourite {
  Favourite({
    this.id,
    this.userId,
    this.barberShopId,
  });

  int? id;
  int? userId;
  int? barberShopId;

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        id: json["id"],
        userId: json["user_id"],
        barberShopId: json["barber_shop_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "barber_shop_id": barberShopId,
      };
}
