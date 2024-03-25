import 'package:application/Screens/Home/TravellerHomePage.dart';
import 'package:application/Screens/LocalGuide/RequestView/ActiveRequest.dart';
import 'package:application/Screens/Traveller/ActiveRequestView.dart';
import 'package:application/Screens/Traveller/PaymentPendingRequest.dart';
import 'package:application/Screens/Traveller/TravellerFirstScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TravellerHomePage()));
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
                        builder: (context) => TravellerHomescreen()));
              },
              icon: Icon(
                Icons.search_sharp,
                size: 40,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActiveRequestTravellerView()));
              },
              icon: Icon(
                Icons.list,
                size: 40,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingPaymentView()));
              },
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
