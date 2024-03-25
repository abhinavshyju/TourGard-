// To parse this JSON data, do
//
//     final guide = guideFromJson(jsonString);

import 'dart:convert';

Guide guideFromJson(String str) => Guide.fromJson(json.decode(str));

String guideToJson(Guide data) => json.encode(data.toJson());

class Guide {
  int id;
  String username;
  String password;
  String type;
  int loginId;
  String name;
  String place;
  int phone;
  String email;
  String imageFile;
  String document;

  Guide({
    required this.id,
    required this.username,
    required this.password,
    required this.type,
    required this.loginId,
    required this.name,
    required this.place,
    required this.phone,
    required this.email,
    required this.imageFile,
    required this.document,
  });

  factory Guide.fromJson(Map<String, dynamic> json) => Guide(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        type: json["type"],
        loginId: json["login_id"],
        name: json["name"],
        place: json["place"],
        phone: json["phone"],
        email: json["email"],
        imageFile: json["image_file"],
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "type": type,
        "login_id": loginId,
        "name": name,
        "place": place,
        "phone": phone,
        "email": email,
        "image_file": imageFile,
        "document": document,
      };
}
