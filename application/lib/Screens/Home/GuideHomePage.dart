import 'dart:convert';

import 'package:application/Model/Vehicle.dart';
import 'package:application/Screens/Compents/BottomNavBAr.dart';
import 'package:application/Screens/Compents/Drawer.dart';
import 'package:application/Screens/Compents/guideBottomNavBar.dart';
import 'package:application/Screens/Home/HomepageTopElement.dart';
import 'package:application/Screens/LocalGuide/LocalguideFristpage.dart';
import 'package:application/Screens/LocalGuide/Vehicle/VehicleUpdate.dart';
import 'package:application/Screens/LocalGuide/Vehicle/VehicleView.dart';
import 'package:application/Screens/Traveller/LocalGuideIndiviual/VehicleDetail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuideHomePage extends StatefulWidget {
  const GuideHomePage({super.key});

  @override
  State<GuideHomePage> createState() => _GuideHomePageState();
}

Vehicle? vehicle;

class _GuideHomePageState extends State<GuideHomePage> {
  @override
  void initState() {
    super.initState();
    getVehicle();
  }

  Future<void> getVehicle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final id = prefs.getInt("userid");
    print(id);

    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final url = "$api/vehicle/get";
    try {
      final Response response = await dio.post(url, data: {"id": id});
      if (response.statusCode == 200) {
        if (response.data != null && response.data.isNotEmpty) {
          setState(() {
            vehicle = vehicleFromJson(response.data);
          });
          print(response.data);
        } else {
          // Handle case when response data is empty or not valid
          print("No vehicle data found");
          setState(() {
            vehicle = null;
          });
        }
      } else {
        // Handle other status codes if needed
        print(
            "Failed to fetch vehicle data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(vehicle?.vehicleImageOne);
    return Scaffold(
        appBar: AppBar(),
        drawer: DrawerComp(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                HomeScreenTopElement(),
                Container(
                    padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Check out your request!",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "LexendDeca",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 24.0),
                                textAlign: TextAlign.left),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                      "Connect with your traveller friend with us",
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "LexendDeca",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0x40000000),
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                          spreadRadius: 0)
                                    ],
                                    color: Color.fromARGB(255, 0, 255, 208)),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LocalguideHomeScreen()));
                                    },
                                    child: Text(
                                      "CheckOut",
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "LexendDeca",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0),
                                    )),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  top: BorderSide(color: Colors.grey))),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x40000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffffffff))),
                vehicle != null
                    ? VehicleVi(
                        name: vehicle?.name,
                        model: vehicle?.vehicleModel,
                        type: vehicle?.vehicleType,
                        imageone: vehicle?.vehicleImageOne,
                        imagetwo: vehicle?.vehicleImageTwo)
                    : UpdateVehicle()
              ],
            ),
          ),
        ),
        bottomNavigationBar: GuideBottomNavBar());
  }
}
