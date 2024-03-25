// To parse this JSON data, do
//
//     final request = requestFromJson(jsonString);

import 'dart:convert';

List<Request> requestFromJson(String str) =>
    List<Request>.from(json.decode(str).map((x) => Request.fromJson(x)));

String requestToJson(List<Request> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
  int id;
  String name;
  String place;
  String contact;
  String email;
  String image;
  int loginId;
  String pickuplocation;

  Request({
    required this.id,
    required this.name,
    required this.place,
    required this.contact,
    required this.email,
    required this.image,
    required this.loginId,
    required this.pickuplocation,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        name: json["name"],
        place: json["place"],
        contact: json["contact"],
        email: json["email"],
        image: json["image"],
        loginId: json["login_id"],
        pickuplocation: json["pickuplocation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "place": place,
        "contact": contact,
        "email": email,
        "image": image,
        "login_id": loginId,
        "pickuplocation": pickuplocation,
      };
}
