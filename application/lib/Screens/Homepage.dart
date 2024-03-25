import 'package:application/Screens/Compents/Drawer.dart';
import 'package:application/Screens/Compents/DropDown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePAge extends StatefulWidget {
  const HomePAge({super.key});

  @override
  State<HomePAge> createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePAge> {
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        backgroundColor: Color(0xffe5e5e5),
      ),
      drawer: const DrawerComp(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                width: double.infinity,
                height: 175,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    // ignore: unnecessary_const
                    color: const Color(0xffffffff)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Text("HELLO, ACHYUTH A",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 18),
                            textAlign: TextAlign.start),
                        SizedBox(
                          height: 8,
                        ),
                        Text("achyudd@gmail.com",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 17),
                            textAlign: TextAlign.start),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text("KOZHIKODE, INDIA",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "LexendDeca",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16),
                                textAlign: TextAlign.start),
                          ],
                        )
                      ],
                    ),
                    Container(
                        height: 100,
                        width: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(
                              color: const Color(0xff00b796), width: 2),
                          boxShadow: [
                            const BoxShadow(
                                color: Color(0x40000000),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "lib/assets/images/profileicon.png")),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 20, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type of transport",
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontFamily: "LexendDeca",
                          fontStyle: FontStyle.normal,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownMenuExample(
                        options: ["Option 1", "Option 2", "Option 3"],
                        onSelectionChanged: (String value) {
                          setState(() {
                            selectedValue = value;
                          });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Vehicle model",
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontFamily: "LexendDeca",
                          fontStyle: FontStyle.normal,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownMenuExample(
                        options: ["Option 1", "Option 2", "Option 3"],
                        onSelectionChanged: (String value) {
                          setState(() {
                            selectedValue = value;
                          });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pick me from",
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontFamily: "LexendDeca",
                          fontStyle: FontStyle.normal,
                          fontSize: 15),
                    ),

                    TextField(
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10, bottom: 0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(193, 255, 255, 255)),
                        ),
                      ),
                    ),

                    // Text('Selected Value: $selectedValue'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Contact Number",
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontFamily: "LexendDeca",
                          fontStyle: FontStyle.normal,
                          fontSize: 15),
                    ),

                    TextField(
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10, bottom: 0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(193, 255, 255, 255)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: const Color(0xffffffff)),
                        child:
                            TextButton(onPressed: () {}, child: Text("Next")),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
