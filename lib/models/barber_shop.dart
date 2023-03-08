// To parse this JSON data, do
//
//     final barberShop = barberShopFromJson(jsonString);

import 'dart:convert';

import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/requester.dart';
import 'package:flutter/services.dart';

List<BarberShop> barberShopListFromJson(String str) =>
    List<BarberShop>.from(json.decode(str).map((x) => BarberShop.fromJson(x)));

String barberShopListToJson(List<BarberShop> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

BarberShop barberShopFromJson(String str) => BarberShop.fromJson(json.decode(str));

String barberShopToJson(BarberShop data) => json.encode(data.toJson());

class BarberShop {
  BarberShop({
    this.id,
    this.name,
    this.description,
    this.location,
    this.phone,
    this.bossId,
    this.instagram,
    this.profilePicture,
    this.isOpen,
    this.isEmpty,
    this.starAverage,
    this.comments,
    this.country,
    this.province,
    this.district,
  });

  int? id;
  String? name;
  String? description;
  String? location;
  String? phone;
  int? bossId;
  String? instagram;
  String? profilePicture;
  bool? isOpen;
  bool? isEmpty;
  double? starAverage;
  int? comments;
  String? country;
  String? province;
  String? district;

  static String table = "barber_shops";

  Uint8List? getImage() {
    if (profilePicture != null || profilePicture == "") {
      return AppManager.instance.hexStringToUint8List(profilePicture!);
    }
    return null;
  }

  setImage(String base64) {
    profilePicture = AppManager.instance.base64ToHexString(base64);
  }

  String starAverageToString() {
    return starAverage == null ? "0.0" : starAverage!.toStringAsFixed(1);
  }

  String provinceToString() {
    return province!.replaceAll("Province", "");
  }

  factory BarberShop.fromJson(Map<String, dynamic> json) => BarberShop(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        phone: json["phone"],
        bossId: json["boss_id"],
        instagram: json["instagram"],
        profilePicture: json["profile_picture"],
        isOpen: json["is_open"],
        isEmpty: json["is_empty"],
        starAverage: (json["star_average"] as int).toDouble(),
        comments: json["comments"],
        country: json["country"],
        province: json["province"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "location": location,
        "phone": phone,
        "boss_id": bossId,
        "instagram": instagram,
        "profile_picture": profilePicture,
        "is_open": isOpen,
        "is_empty": isEmpty,
        "star_average": starAverage,
        "comments": comments,
        "country": country,
        "province": province,
        "district": district,
      };

  //#region requests

  static Future<BarberShop?> create({
    required String name,
    required String description,
    required String location,
    required String phone,
    required int bossId,
    required String instagram,
    required String country,
    required String province,
    required String district,
    required String profilePictureBase64,
  }) async {
    final result = await Requester.postReq(
        "/$table",
        barberShopToJson(BarberShop(
          name: name,
          description: description,
          location: location,
          phone: phone,
          bossId: bossId,
          instagram: instagram,
          country: country,
          province: province,
          district: district,
          profilePicture: profilePictureBase64,
        )));
    if (Requester.isSuccess)
      return barberShopFromJson(result);
    else
      return null;
  }

  static Future<List<BarberShop>> getAll() async {
    final result = await Requester.getReq("/$table");
    if (Requester.isSuccess)
      return barberShopListFromJson(result);
    else
      return [];
  }

  static Future<List<BarberShop>> getUserShop({required int userId}) async {
    final result = await Requester.getReq("/$table/my/$userId");
    if (Requester.isSuccess)
      return barberShopListFromJson(result);
    else
      return [];
  }

  static Future<List<BarberShop>> getWorkers({required int workerId}) async {
    final result = await Requester.getReq("/$table/worker/$workerId");
    if (Requester.isSuccess)
      return barberShopListFromJson(result);
    else
      return [];
  }

  static Future<List<BarberShop>> getShops({required List<int> ids}) async {
    final result = await Requester.postReq("/$table/ids", jsonEncode({ids}));
    if (Requester.isSuccess)
      return barberShopListFromJson(result);
    else
      return [];
  }

  static Future<List<BarberShop>> getPopulars({
    required String country,
    required String province,
    required String district,
  }) async {
    final result = await Requester.postReq(
        "/$table/popular",
        barberShopToJson(BarberShop(
          country: country,
          province: province,
          district: district,
        )));
    if (Requester.isSuccess)
      return barberShopListFromJson(result);
    else
      return [];
  }

  static Future<List<BarberShop>> getNearby({
    required String country,
    required String province,
    required String district,
  }) async {
    final result = await Requester.postReq(
        "/$table/nearby",
        barberShopToJson(BarberShop(
          country: country,
          province: province,
          district: district,
        )));
    if (Requester.isSuccess)
      return barberShopListFromJson(result);
    else
      return [];
  }

  static Future<BarberShop?> get({required int id}) async {
    final result = await Requester.getReq("/$table/$id");
    if (Requester.isSuccess)
      return barberShopFromJson(result);
    else
      return null;
  }

  static Future<BarberShop?> getData({
    required int id,
    required String column,
  }) async {
    final result = await Requester.getReq("/$table/data/$id/$column");
    if (Requester.isSuccess)
      return barberShopFromJson(result);
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
      jsonEncode({"data": data}),
    );
    return result;
  }

  static Future<bool> setImageReq({
    required int id,
    required String base64Image,
  }) async {
    final result = await Requester.putReq(
      "/$table/set_image/$id",
      barberShopToJson(BarberShop(profilePicture: base64Image)),
    );
    return result;
  }

  static Future<bool> addComment({
    required int cafeId,
    required int userId,
    required double starAverage,
  }) async {
    final result = await Requester.putReq(
      "/$table/add_comment/$cafeId/$userId",
      jsonEncode({starAverage}),
    );
    return result;
  }

  static Future<bool> changeLocation({
    required int id,
    required String country,
    required String province,
    required String district,
  }) async {
    final result = await Requester.putReq(
      "/$table/change_location/$id",
      barberShopToJson(BarberShop(country: country, province: province, district: district)),
    );
    return result;
  }

  static Future<bool> delete({required int id}) async {
    final result = await Requester.deleteReq("/$table/$id");
    return result;
  }
  //#endregion
}
