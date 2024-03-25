import 'package:application/Screens/Home/GuideHomePage.dart';
import 'package:application/Screens/LocalGuide/LocalguideFristpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuideBottomNavBar extends StatelessWidget {
  const GuideBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GuideHomePage()));
              },
              icon: Icon(
                Icons.home_filled,
                size: 40,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocalguideHomeScreen()));
              },
              icon: Icon(
                Icons.list,
                size: 40,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active,
                size: 40,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                size: 40,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
