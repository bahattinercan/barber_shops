// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

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
}
