import 'package:flutter/material.dart';

import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OpenStreetMapSearchAndPick(
      buttonTextStyle:
          const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
      buttonColor: Colors.blue,
      buttonText: 'Set Current Location',
      onPicked: (pickedData) {
        print(pickedData.latLong.latitude);
        print(pickedData.latLong.longitude);
        print(pickedData.address);
        print(pickedData.addressName);
      },
    ));
  }
}
