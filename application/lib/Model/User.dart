// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String username;
  String password;
  String type;
  int loginId;
  String name;
  String place;
  dynamic post;
  int phone;
  String email;
  String imageFile;
  String documentFile;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.type,
    required this.loginId,
    required this.name,
    required this.place,
    required this.post,
    required this.phone,
    required this.email,
    required this.imageFile,
    required this.documentFile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        type: json["type"],
        loginId: json["login_id"],
        name: json["name"],
        place: json["place"],
        post: json["post"],
        phone: json["phone"],
        email: json["email"],
        imageFile: json["image_file"],
        documentFile: json["document_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "type": type,
        "login_id": loginId,
        "name": name,
        "place": place,
        "post": post,
        "phone": phone,
        "email": email,
        "image_file": imageFile,
        "document_file": documentFile,
      };
}
