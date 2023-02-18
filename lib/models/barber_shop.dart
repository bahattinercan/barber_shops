// To parse this JSON data, do
//
//     final barberShop = barberShopFromJson(jsonString);

import 'dart:convert';

import 'package:barbers/utils/app_manager.dart';
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
}
