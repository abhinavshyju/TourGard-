import 'package:application/Screens/EntryScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerComp extends StatefulWidget {
  const DrawerComp({super.key});

  @override
  State<DrawerComp> createState() => _DrawerCompState();
}

class _DrawerCompState extends State<DrawerComp> {
  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("type");
    await prefs.remove("email");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EntryScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                // color: Colors.blue,
                ),
            child: Text(
              'TourGuard',
              style: TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                  fontFamily: "LexendDeca",
                  fontStyle: FontStyle.normal,
                  fontSize: 28.0),
            ),
          ),
          ListTile(
            title: Text(
              'Edit Profile',
              style: TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "LexendDeca",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Signout',
              style: TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "LexendDeca",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0),
            ),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }
}
