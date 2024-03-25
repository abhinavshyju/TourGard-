import 'dart:convert';

import 'package:application/Screens/Traveller/LocalGuideIndiviual/LocalGuideCard.dart';
import 'package:application/Screens/Traveller/LocalGuideInduvidual.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NearByLocalGuideScreen extends StatefulWidget {
  const NearByLocalGuideScreen({super.key});

  @override
  State<NearByLocalGuideScreen> createState() => _NearByLocalGuideScreenState();
}

class _NearByLocalGuideScreenState extends State<NearByLocalGuideScreen> {
  List<dynamic>? guides;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final type = prefs.getString("typeOfTransport");
    final model = prefs.getString("vehiclemodel");
    print(model);
    print(type);
    try {
      await dotenv.load(fileName: "lib/.env");
      var api = dotenv.env["VAR_API"];
      final dio = Dio();
      final response = await dio
          .post("$api/localguide", data: {"type": type, "model": model});
      setState(() {
        guides = response.data;
      });
      print(response.data);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 40, 18, 18),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                )
              ],
              color: Color(0xffffffff),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.keyboard_backspace,
                    size: 26,
                  ),
                ),
                const Text(
                  "Local guides near you",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: guides != null
                ? ListView.builder(
                    itemCount: guides!.length,
                    itemBuilder: (context, index) {
                      final guide = guides![index];
                      return GuideCard(
                        name: guide["name"],
                        image: guide["image_file"], // Replace with correct key
                        place: guide["place"],
                        id: guide["id"],
                        guide_id: guide["login_id"],
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
