// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  int id;
  int senderId;
  int reciverId;
  String date;
  String message;

  Message({
    required this.id,
    required this.senderId,
    required this.reciverId,
    required this.date,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        senderId: json["sender_id"],
        reciverId: json["reciver_id"],
        date: json["date"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "reciver_id": reciverId,
        "date": date,
        "message": message,
      };
}
