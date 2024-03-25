import 'package:application/Screens/Compents/Drawer.dart';
import 'package:application/Screens/Home/HomepageTopElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveRequest extends StatefulWidget {
  const ActiveRequest({super.key});

  @override
  State<ActiveRequest> createState() => _ActiveRequestState();
}

class _ActiveRequestState extends State<ActiveRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: DrawerComp(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(30),
                child:
                    Column(children: [HomeScreenTopElement(), Container()]))));
  }
}
