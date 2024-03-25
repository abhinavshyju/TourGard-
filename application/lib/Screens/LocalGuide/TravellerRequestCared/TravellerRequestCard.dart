import 'package:application/Screens/Chat/chatScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TravellerRequestCard extends StatefulWidget {
  var email;

  var place;

  var contact;

  var pickuplocation;

  var id;

  var image;

  var travellerid;

  TravellerRequestCard(
      {super.key,
      required this.email,
      required this.place,
      required this.contact,
      required this.pickuplocation,
      required this.id,
      required this.image,
      required this.travellerid});

  @override
  State<TravellerRequestCard> createState() => _TravellerRequestCardState();
}

class _TravellerRequestCardState extends State<TravellerRequestCard> {
  String imageurl = " ";
  Future<void> startCaht() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("guide_id", widget.travellerid);
    print(widget.travellerid);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatScreen()));
  }

  Future<void> acceptRequest() async {
    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final url = "$api/request/accept";
    try {
      final Response respones = await dio.post(url, data: {"id": widget.id});
      if (respones.statusCode == 200) {
        print("Request accepted");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> delineRequest() async {
    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final url = "$api/request/deline";
    try {
      final Response respones = await dio.post(url, data: {"id": widget.id});
      if (respones.statusCode == 200) {
        print("Request deline");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        // height: 198,
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x40000000),
                  offset: Offset(0, -4),
                  blurRadius: 4,
                  spreadRadius: 0)
            ],
            color: const Color(0xff008870)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.email,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontFamily: "LexendDeca",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0),
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.place,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w800,
                            fontFamily: "LexendDeca",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Contact Number",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            fontFamily: "LexendDeca",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
                    Text(widget.contact,
                        style: const TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w500,
                            fontFamily: "LexendDeca",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
                    Text("Pickup location",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            fontFamily: "LexendDeca",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
                    if (widget.pickuplocation != null)
                      Text(widget.pickuplocation,
                          style: const TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w500,
                              fontFamily: "LexendDeca",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                          textAlign: TextAlign.left)
                    else
                      Text("place",
                          style: const TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w500,
                              fontFamily: "LexendDeca",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                          textAlign: TextAlign.left),
                  ],
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    border:
                        Border.all(color: const Color(0xff00b796), width: 2),
                    boxShadow: [
                      const BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://qgbk7vxz-8000.inc1.devtunnels.ms${widget.image}"),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    startCaht();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x40000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffffffff)),
                    child: Text("Chat",
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
                    delineRequest();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x40000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: Color.fromARGB(255, 255, 0, 0)),
                    child: Text("Deline",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
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
                    acceptRequest();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x40000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: Color.fromARGB(255, 102, 255, 0)),
                    child: Text("Accept",
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
            )
          ],
        ));
  }
}
