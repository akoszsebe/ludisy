import 'package:flutter/cupertino.dart';

class Developer {
  String name;
  String role;
  AssetImage photo;
  String url;

  Developer({
    this.name, this.role, this.photo, this.url
  });

  factory Developer.fromJson(Map<String, dynamic> json) => Developer(
      name: json["name"],
      photo: json["photo"],
      role: json["role"],
      url: json["url"]);
}