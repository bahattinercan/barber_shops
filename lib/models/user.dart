// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:barbers/enums/user.dart';

List<User> userListFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userListToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.email,
    this.password,
    this.fullname,
    this.accessToken,
    this.phoneNo,
    this.authority,
    this.type,
    this.country,
    this.province,
    this.district,
  });

  int? id;
  String? email;
  String? password;
  String? fullname;
  String? accessToken;
  String? phoneNo;
  bool? authority;
  String? country;
  String? province;
  String? district;

  /// 1:kullanıcı, 2: çalışan, 3:müdür, 4:admin
  int? type;

  EUser get getType {
    switch (type) {
      case 1:
        return EUser.normal;
      case 2:
        return EUser.worker;
      case 3:
        return EUser.boss;
      case 4:
        return EUser.admin;
      default:
        return EUser.normal;
    }
  }

  void setType(EUser userType) {
    switch (userType) {
      case EUser.normal:
        type = 1;
        break;
      case EUser.worker:
        type = 2;
        break;
      case EUser.boss:
        type = 3;
        break;
      case EUser.admin:
        type = 4;
        break;
    }
  }

  String provinceToString() {
    return province!.replaceAll("Province", "");
  }

  String districtToString() {
    return district!.replaceAll("İlçesi", "");
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        fullname: json["fullname"],
        accessToken: json["access_token"],
        phoneNo: json["phone_no"],
        authority: json["authority"],
        type: json["type"],
        country: json["country"],
        province: json["province"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "fullname": fullname,
        "access_token": accessToken,
        "phone_no": phoneNo,
        "authority": authority,
        "type": type,
        "country": country,
        "province": province,
        "district": district,
      };
}
