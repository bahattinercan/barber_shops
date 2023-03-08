// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

import 'package:barbers/utils/requester.dart';

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

  static String table = "services";

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

  //#region

  static Future<Service?> create({
    required String name,
    required String price,
    required int userId,
    required int shopId,
  }) async {
    final result = await Requester.postReq(
        "/$table",
        serviceToJson(Service(
          name: name,
          price: price,
          userId: userId,
          barberShopId: shopId,
        )));
    if (Requester.isSuccess) {
      return serviceFromJson(result);
    } else {
      return null;
    }
  }

  static Future<List<Service>> getAll() async {
    final result = await Requester.getReq("/$table");
    if (Requester.isSuccess) {
      return serviceListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<List<Service>> getShops({required int shopId}) async {
    final result = await Requester.getReq("/$table/barber_shop/$shopId");
    if (Requester.isSuccess) {
      return serviceListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<Service?> get({required int id}) async {
    final result = await Requester.getReq("/$table/$id");
    if (Requester.isSuccess) {
      return serviceFromJson(result);
    } else {
      return null;
    }
  }

  static Future<Service?> getData({required int id, required String column}) async {
    final result = await Requester.getReq("/$table/data/$id/$column");
    if (Requester.isSuccess) {
      return serviceFromJson(result);
    } else {
      return null;
    }
  }

  static Future<bool> setImageReq({
    required int id,
    required String base64Image,
  }) async {
    final result = await Requester.putReq(
      "/$table/set_image/$id",
      serviceToJson(Service(image: base64Image)),
    );
    return result;
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
