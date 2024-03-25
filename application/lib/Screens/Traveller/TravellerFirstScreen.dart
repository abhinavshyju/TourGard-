import 'package:application/Model/User.dart';
import 'package:application/Screens/Compents/BottomNavBAr.dart';
import 'package:application/Screens/Compents/Drawer.dart';
import 'package:application/Screens/Compents/HometopSectiom.dart';
import 'package:application/Screens/Traveller/FirstPageElements/FristScreenForm.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";
import 'package:shared_preferences/shared_preferences.dart';

class TravellerHomescreen extends StatefulWidget {
  const TravellerHomescreen({super.key});

  @override
  State<TravellerHomescreen> createState() => _TravellerHomescreenState();
}

class _TravellerHomescreenState extends State<TravellerHomescreen> {
  User? traveller;

  @override
  void initState() {
    super.initState();
    userCheck();
  }

  Future<void> userCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');

    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final response = await dio.get('$api/traveller/user/$email');
    // print(response.data);

    setState(() {
      traveller = User.fromJson(response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      // backgroundColor: Color(0xFFE5E5E5),
      drawer: DrawerComp(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Use traveller data in your widgets
            traveller != null
                ? HomeScreenTopSection(
                    name: traveller!.name,
                    email: traveller!.email,
                    place: traveller!.place,
                    image: traveller!.imageFile,
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
            FristScreenForm(),
          ],
        ),
      ),
    );
  }
}
