// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:barbers/enums/user.dart';
import 'package:barbers/utils/requester.dart';

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

  static String table = "users";

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

  //#region requests

  static Future<bool> signin({
    required String email,
    required String password,
    required String fullname,
    required String phone,
    required String country,
    required String province,
    required String district,
  }) async {
    await Requester.postReq(
        "/$table",
        userToJson(User(
          email: email,
          password: password,
          fullname: fullname,
          phoneNo: phone,
          country: country,
          province: province,
          district: district,
        )));
    if (Requester.isSuccess)
      return true;
    else
      return false;
  }

  static Future<User?> login({required String email, required String password}) async {
    final result = await Requester.postReq("/$table/login", userToJson(User(email: email, password: password)));
    if (Requester.isSuccess)
      return userFromJson(result);
    else
      return null;
  }

  static Future<User?> tokenLogin({required String token}) async {
    final result = await Requester.postReq("/$table/token_login", userToJson(User(accessToken: token)));
    if (Requester.isSuccess)
      return userFromJson(result);
    else
      return null;
  }

  static Future<bool> logout({required String token}) async {
    // final result = await Requester.putReq("/$table/logout", null);
    // return result;
    return true;
  }

  static Future<List<User>> getUsers({required List<int> ids}) async {
    final result = await Requester.postReq("/$table/with_ids", jsonEncode({ids}));
    if (Requester.isSuccess)
      return userListFromJson(result);
    else
      return [];
  }

  static Future<bool> checkAuthority({required bool authority, required int id}) async {
    final res = await Requester.putReq("/$table/authority", userToJson(User(authority: authority, id: id)));
    return res;
  }

  static Future<bool> changePassword({
    required int id,
    required String newPassword,
    required String password,
  }) async {
    final res = await Requester.putReq(
      "/$table/change_password/$id",
      jsonEncode({"newPassword": newPassword, "password": password}),
    );
    return res;
  }

  static Future<bool> changeEmail({
    required int id,
    required String newEmail,
    required String email,
  }) async {
    final res = await Requester.putReq(
      "/$table/change_email/$id",
      jsonEncode({"newEmail": newEmail, "email": email}),
    );
    return res;
  }

  static Future<bool> changeLocation({
    required int id,
    required String country,
    required String province,
    required String district,
  }) async {
    final res = await Requester.putReq(
        "/$table/change_location/$id",
        userToJson(User(
          country: country,
          province: province,
          district: district,
        )));
    return res;
  }

  static Future<bool> resetPassword({
    required int id,
    required String password,
  }) async {
    final res = await Requester.putReq(
        "/$table/reset_password/$id",
        userToJson(User(
          password: password,
        )));
    return res;
  }

  static Future<int?> hasEmail({required String email}) async {
    final result = await Requester.getReq("/$table/has_email/$email");
    if (Requester.isSuccess)
      return jsonDecode(result)["id"];
    else
      return null;
  }

  static Future<int?> hasPhone({required String phone}) async {
    final result = await Requester.getReq("/$table/has_phone/$phone");
    if (Requester.isSuccess)
      return jsonDecode(result)["id"];
    else
      return null;
  }

  static Future<User?> getData({required int id, required String column}) async {
    final result = await Requester.getReq("/$table/data/$id/$column");
    if (Requester.isSuccess)
      return userFromJson(result);
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
