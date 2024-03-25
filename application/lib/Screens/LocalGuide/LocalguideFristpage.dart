import 'dart:convert';

import 'package:application/Model/Request.dart';
import 'package:application/Screens/Compents/HometopSectiom.dart';
import 'package:application/Screens/Compents/guideBottomNavBar.dart';
import 'package:application/Screens/LocalGuide/RequestView/AcceptRequest.dart';
import 'package:flutter/material.dart';
import 'package:application/Screens/Compents/Drawer.dart';
import 'package:application/Screens/LocalGuide/TravellerRequestCared/TravellerRequestCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalguideHomeScreen extends StatefulWidget {
  const LocalguideHomeScreen({Key? key}) : super(key: key);

  @override
  State<LocalguideHomeScreen> createState() => _LocalguideHomeScreenState();
}

class _LocalguideHomeScreenState extends State<LocalguideHomeScreen> {
  Map<String, dynamic>? localguide;
  List<Request> requests = [];

  @override
  void initState() {
    super.initState();
    userCheck();
    getdata();
  }

  Future<void> userCheck() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');

      await dotenv.load(fileName: "lib/.env");
      var api = dotenv.env["VAR_API"];
      final Dio dio = Dio();

      final localGuideResponse =
          await dio.get('$api/localguide/user/get/$email');
      setState(() {
        localguide = localGuideResponse.data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> getdata() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');
      await dotenv.load(fileName: "lib/.env");
      var api = dotenv.env["VAR_API"];
      final dio = Dio();
      final Response response =
          await dio.get("$api/request/guide/active/$email");

      setState(() {
        requests =
            requestFromJson(response.data); // Add a single Request object
        // testData = response;
      });
      print(response.data);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GuideBottomNavBar(),
      drawer: DrawerComp(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            localguide != null
                ? HomeScreenTopSection(
                    name: localguide!["name"],
                    email: localguide!["email"],
                    place: localguide!["place"],
                    image: localguide!["image_file"],
                  )
                : CircularProgressIndicator(),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcceptRequest()));
                      // startCaht();
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x40000000),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: Color.fromARGB(255, 251, 251, 251)),
                      child: Text("Accepted ",
                          style: const TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w800,
                              fontFamily: "LexendDeca",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // startCaht();
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x40000000),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: Color.fromARGB(255, 251, 251, 251)),
                      child: Text("Pending ",
                          style: const TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w800,
                              fontFamily: "LexendDeca",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              child: Container(
                padding: const EdgeInsets.all(18),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                  color: const Color(0xffffffff),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Customer details",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w900,
                        fontFamily: "LexendDeca",
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 20),
                    requests.isNotEmpty
                        ? Column(
                            children: requests.map((item) {
                              return Column(
                                children: [
                                  TravellerRequestCard(
                                    email: item.email,
                                    place: item.place,
                                    contact: item.contact,
                                    pickuplocation: item.pickuplocation,
                                    id: item.id,
                                    image: item.image,
                                    travellerid: item.loginId,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            }).toList(),
                          )
                        : Text("No request"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
