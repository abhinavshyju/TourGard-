// To parse this JSON data, do
//
//     final vehicle = vehicleFromJson(jsonString);

import 'dart:convert';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  int id;
  String name;
  String vehicleType;
  String vehicleModel;
  String vehicleImageOne;
  String vehicleImageTwo;
  int localGuideId;

  Vehicle({
    required this.id,
    required this.name,
    required this.vehicleType,
    required this.vehicleModel,
    required this.vehicleImageOne,
    required this.vehicleImageTwo,
    required this.localGuideId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        name: json["name"],
        vehicleType: json["vehicle_type"],
        vehicleModel: json["vehicle_model"],
        vehicleImageOne: json["vehicle_image_one"],
        vehicleImageTwo: json["vehicle_image_two"],
        localGuideId: json["local_guide_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "vehicle_type": vehicleType,
        "vehicle_model": vehicleModel,
        "vehicle_image_one": vehicleImageOne,
        "vehicle_image_two": vehicleImageTwo,
        "local_guide_id": localGuideId,
      };
}
