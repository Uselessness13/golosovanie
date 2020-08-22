// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    this.name,
    this.id,
  });
  int id;
  String name;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) =>
      User(name: json["name"], id: json["id"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
