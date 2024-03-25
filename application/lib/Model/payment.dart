// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  int id;
  String name;
  String place;
  String contact;
  String email;
  String image;
  int loginId;
  String pickuplocation;
  PaymentClass payment;

  Payment({
    required this.id,
    required this.name,
    required this.place,
    required this.contact,
    required this.email,
    required this.image,
    required this.loginId,
    required this.pickuplocation,
    required this.payment,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        name: json["name"],
        place: json["place"],
        contact: json["contact"],
        email: json["email"],
        image: json["image"],
        loginId: json["login_id"],
        pickuplocation: json["pickuplocation"],
        payment: PaymentClass.fromJson(json["payment"]),
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
        "payment": payment.toJson(),
      };
}

class PaymentClass {
  int id;
  int amount;
  String date;
  String status;
  int travellerId;
  int localGuideId;
  int tripId;

  PaymentClass({
    required this.id,
    required this.amount,
    required this.date,
    required this.status,
    required this.travellerId,
    required this.localGuideId,
    required this.tripId,
  });

  factory PaymentClass.fromJson(Map<String, dynamic> json) => PaymentClass(
        id: json["id"],
        amount: json["amount"],
        date: json["date"],
        status: json["status"],
        travellerId: json["traveller_id"],
        localGuideId: json["local_guide_id"],
        tripId: json["trip_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "date": date,
        "status": status,
        "traveller_id": travellerId,
        "local_guide_id": localGuideId,
        "trip_id": tripId,
      };
}
