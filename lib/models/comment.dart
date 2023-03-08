// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

import 'package:barbers/utils/requester.dart';

List<Comment> commentListFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentListToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    this.id,
    this.userId,
    this.comment,
    this.barberShopId,
    this.stars,
    this.time,
    this.fullname,
  });

  int? id;
  int? userId;
  String? comment;
  int? barberShopId;
  int? stars;
  DateTime? time;
  String? fullname;

  static String table = "comments";

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        comment: json["comment"],
        barberShopId: json["barber_shop_id"],
        stars: json["stars"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "comment": comment,
        "barber_shop_id": barberShopId,
        "stars": stars,
        "time": time?.toIso8601String(),
        "fullname": fullname,
      };

  //#region requests

  static Future<Comment?> create({
    required int userId,
    required String comment,
    required DateTime time,
    required int shopId,
    required int stars,
  }) async {
    final result = await Requester.postReq(
        "/$table",
        commentToJson(Comment(
          userId: userId,
          comment: comment,
          time: time,
          barberShopId: shopId,
          stars: stars,
        )));
    if (Requester.isSuccess) {
      return commentFromJson(result);
    } else {
      return null;
    }
  }

  static Future<Comment?> update({
    required int userId,
    required String comment,
    required DateTime time,
    required int shopId,
    required int stars,
  }) async {
    final result = await Requester.postReq(
        "/$table/update",
        commentToJson(Comment(
          userId: userId,
          comment: comment,
          time: time,
          barberShopId: shopId,
          stars: stars,
        )));
    if (Requester.isSuccess) {
      return commentFromJson(result);
    } else {
      return null;
    }
  }

  static Future<List<Comment>> getAll() async {
    final result = await Requester.getReq("/$table");
    if (Requester.isSuccess) {
      return commentListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<List<Comment>> getShops({required int shopId}) async {
    final result = await Requester.getReq("/$table/shop/$shopId");
    if (Requester.isSuccess) {
      return commentListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<List<Comment>> getUsers({required int userId}) async {
    final result = await Requester.getReq("/$table/user/$userId");
    if (Requester.isSuccess) {
      return commentListFromJson(result);
    } else {
      return [];
    }
  }

  static Future<double?> getStarAverage({required int shopId}) async {
    final result = await Requester.getReq("/$table/shop/$shopId");
    if (Requester.isSuccess) {
      return jsonDecode(result)["average"];
    } else {
      return null;
    }
  }

  static Future<Comment?> get({
    required int id,
  }) async {
    final result = await Requester.getReq("/$table/$id");
    if (Requester.isSuccess) {
      return commentFromJson(result);
    } else {
      return null;
    }
  }

  static Future<Comment?> getData({
    required int id,
    required String column,
  }) async {
    final result = await Requester.getReq("/$table/data/$id/$column");
    if (Requester.isSuccess) {
      return commentFromJson(result);
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
