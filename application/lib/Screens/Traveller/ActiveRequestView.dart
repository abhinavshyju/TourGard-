import 'package:application/Model/Request.dart';
import 'package:application/Screens/Compents/BottomNavBAr.dart';
import 'package:application/Screens/Compents/Drawer.dart';
import 'package:application/Screens/Compents/HometopSectiom.dart';
import 'package:application/Screens/Compents/guideBottomNavBar.dart';
import 'package:application/Screens/LocalGuide/LocalguideFristpage.dart';
import 'package:application/Screens/LocalGuide/RequestView/AcceptedRequestCard.dart';
import 'package:application/Screens/LocalGuide/TravellerRequestCared/TravellerRequestCard.dart';
import 'package:application/Screens/Traveller/AcceptedRequestView.dart';
import 'package:application/Screens/Traveller/DelineRequestView.dart';
import 'package:application/Screens/Traveller/RequestCardTravellerView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveRequestTravellerView extends StatefulWidget {
  const ActiveRequestTravellerView({super.key});

  @override
  State<ActiveRequestTravellerView> createState() =>
      ActiveRequestTravellerViewState();
}

class ActiveRequestTravellerViewState
    extends State<ActiveRequestTravellerView> {
  Map<String, dynamic>? localguide;
  List<Request> requests = [];

  @override
  void initState() {
    super.initState();
    // userCheck();
    getdata();
  }

  Future<void> getdata() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');
      await dotenv.load(fileName: "lib/.env");
      var api = dotenv.env["VAR_API"];
      final dio = Dio();
      final Response response =
          await dio.get("$api/request/traveller/active/$email");

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
      bottomNavigationBar: BottomNavBar(),
      drawer: DrawerComp(),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
                color: const Color(0xff008870),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Trip request",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w900,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 36.0),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 0),
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // startCaht();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActiveRequestTravellerView()));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                        TextButton(
                          onPressed: () {
                            // startCaht();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AcceptRequestTravellerView()));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DelineRequestTravellerView()));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                                color: Color.fromARGB(255, 251, 251, 251)),
                            child: Text("Deline",
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
                  )),
              SizedBox(
                height: 30,
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
                        "Pending trip",
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
                                    TravellerRequestCardView(
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
        ],
      )),
    );
  }
}
