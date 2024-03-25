import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

List<Client> clientFromJson(String str) =>
    List<Client>.from(json.decode(str).map((x) => Client.fromJson(x)));

String clientToJson(List<Client> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Client {
  int id;
  String username;
  String password;
  String type;
  int loginId;
  String name;
  String place;
  String phone;
  String email;
  String imageFile;
  String document;

  Client({
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

  factory Client.fromJson(Map<String, dynamic> json) => Client(
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

// ignore: must_be_immutable
class Testing extends StatelessWidget {
  Testing({super.key});

  List<Client> clientdata = [];

  Future<void> getData() async {
    try {
      // Load environment variables
      await dotenv.load(fileName: "lib/.env");
      var api = dotenv.env["VAR_API"];

      // Create a Dio instance
      final dio = Dio();

      // Make the HTTP GET request to the API endpoint
      final response = await dio.get("$api/localguide/");

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the JSON data into a list of Client objects
        clientdata =
            List<Client>.from(response.data.map((x) => Client.fromJson(x)));

        // Print the usernames of clients (for testing purposes)
        clientdata.forEach((client) {
          print(client.username);
        });
      } else {
        // Handle error response
        print('Failed to load data, status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text("Click"),
        onPressed: () {
          getData();
        },
      ),
    );
  }
}
