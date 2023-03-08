// To parse this JSON data, do
//
//     final worker = workerFromJson(jsonString);

import 'dart:convert';

import 'package:barbers/utils/requester.dart';

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
    this.fullname,
    this.phoneNo,
  });

  int? id;
  int? userId;
  int? barberShopId;
  String? image;
  String? fullname;
  String? phoneNo;

  static String table = "workers";

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"],
        userId: json["user_id"],
        barberShopId: json["barber_shop_id"],
        image: json["image"],
        fullname: json["fullname"],
        phoneNo: json["phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "barber_shop_id": barberShopId,
        "image": image,
        "phone_no": phoneNo,
      };

  //#region requests

  static Future<Worker?> create({required int userId, required int shopId}) async {
    final res = await Requester.postReq(
      "/$table",
      workerToJson(Worker(userId: userId, barberShopId: shopId)),
    );
    if (Requester.isSuccess)
      return workerFromJson(res);
    else
      return null;
  }

  static Future<List<Worker>> getAll() async {
    final result = await Requester.getReq("/$table");
    if (Requester.isSuccess)
      return workerListFromJson(result);
    else
      return [];
  }

  static Future<List<Worker>> getJobs({required int userId}) async {
    final result = await Requester.getReq("/$table/jobs/$userId");
    if (Requester.isSuccess)
      return workerListFromJson(result);
    else
      return [];
  }

  static Future<List<int>> getShopIds({required int userId}) async {
    final result = await Requester.getReq("/$table/shopIds/$userId");
    if (Requester.isSuccess) {
      List<Worker> workers = workerListFromJson(result);
      return List<int>.from(workers.map((x) => x.barberShopId));
    } else
      return [];
  }

  static Future<List<Worker>> getShops({required int shopId}) async {
    final result = await Requester.getReq("/$table/shop/$shopId");
    if (Requester.isSuccess)
      return workerListFromJson(result);
    else
      return [];
  }

  static Future<Worker?> get({required int id}) async {
    final result = await Requester.getReq("/$table/$id");
    if (Requester.isSuccess)
      return workerFromJson(result);
    else
      return null;
  }

  static Future<Worker?> getData({required int id, required String column}) async {
    final result = await Requester.getReq("/$table/data/$id/$column");
    if (Requester.isSuccess)
      return workerFromJson(result);
    else
      return null;
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
