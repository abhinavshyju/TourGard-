import 'package:application/Screens/Compents/BottomNavBAr.dart';
import 'package:application/Screens/Compents/Drawer.dart';
import 'package:application/Screens/Home/HomepageTopElement.dart';
import 'package:application/Screens/Traveller/TravellerFirstScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TravellerHomePage extends StatefulWidget {
  const TravellerHomePage({super.key});

  @override
  State<TravellerHomePage> createState() => _TravellerHomePagwState();
}

class _TravellerHomePagwState extends State<TravellerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: DrawerComp(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            height: MediaQuery.of(context).size.height,
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
                            Text("Start your trip!",
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
                                      "Embark on Your Adventure: Plan Your Trip with Us",
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
                                                  TravellerHomescreen()));
                                    },
                                    child: Text(
                                      "Start",
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar());
  }
}
