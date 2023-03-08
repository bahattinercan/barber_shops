// To parse this JSON data, do
//
//     final favourite = favouriteFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

import 'package:barbers/utils/requester.dart';

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

  static String table = "favourites";

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

  //#region requests

  static Future<Favourite?> create({required int userId, required int shopId}) async {
    final result = await Requester.postReq(
      "/$table",
      favouriteToJson(Favourite(userId: userId, barberShopId: shopId)),
    );
    if (Requester.isSuccess) {
      return favouriteFromJson(result);
    } else {
      return null;
    }
  }

  static Future<List<Favourite>> getAll() async {
    final result = await Requester.getReq("/$table");
    if (Requester.isSuccess) {
      return favouriteListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<List<Favourite>> getUserFavs({required int userId}) async {
    final result = await Requester.getReq("/$table/my/$userId");
    if (Requester.isSuccess) {
      return favouriteListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<Favourite?> get({required int id}) async {
    final result = await Requester.getReq("/$table/$id");
    if (Requester.isSuccess) {
      return favouriteFromJson(result);
    } else {
      return null;
    }
  }

  static Future<Favourite?> getData({required int id, required String column}) async {
    final result = await Requester.getReq("/$table/data/$id/$column");
    if (Requester.isSuccess) {
      return favouriteFromJson(result);
    } else {
      return null;
    }
  }

  static Future<bool> setData({
    required int id,
    required String column,
    required dynamic data,
  }) async {
    final result = await Requester.putReq(
        "/$table/data/$id/$column",
        jsonEncode({
          "data": data,
        }));
    return result;
  }

  static Future<bool> delete({required int id}) async {
    final result = await Requester.deleteReq("/$table/$id");
    return result;
  }

  //#endregion
}
