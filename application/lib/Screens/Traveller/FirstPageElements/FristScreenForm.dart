import 'package:application/Screens/Compents/DropDown.dart';
import 'package:application/Screens/Traveller/NearByLocalGuideList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FristScreenForm extends StatefulWidget {
  const FristScreenForm({super.key});

  @override
  State<FristScreenForm> createState() => _FristScreenFormState();
}

class _FristScreenFormState extends State<FristScreenForm> {
  String _typeoftrasport = "";
  String _vehiclemodel = "";
  final TextEditingController _currentloaction = TextEditingController();
  final TextEditingController _destination = TextEditingController();

  Future<void> saveInfo(
      typeOfTransport, vehiclemodel, currentlocation, destination) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("typeOfTransport", typeOfTransport);
    prefs.setString("vehiclemodel", vehiclemodel);
    prefs.setString("currentlocation", currentlocation);
    prefs.setString("constact", destination);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NearByLocalGuideScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                options: ["Two wheeler", "Four wheeler"],
                onSelectionChanged: (String value) {
                  setState(() {
                    _typeoftrasport = value;
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
                options: ["Class A", "Class B", "Class C", "Class S"],
                onSelectionChanged: (String value) {
                  setState(() {
                    _vehiclemodel = value;
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
              controller: _currentloaction,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18,
                fontFamily: 'Lexend Deca',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 25, bottom: 0),
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
              controller: _destination,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18,
                fontFamily: 'Lexend Deca',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(top: 25, bottom: 0),
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
                    color: Colors.blue),
                child: TextButton(
                    onPressed: () {
                      String currentlocation = _currentloaction.text;
                      String destination = _destination.text;
                      String typeOfTransport = _typeoftrasport;
                      String vehiclemodel = _vehiclemodel;
                      if (currentlocation != "" &&
                          destination != "" &&
                          vehiclemodel != "" &&
                          typeOfTransport != "") {
                        saveInfo(typeOfTransport, vehiclemodel, currentlocation,
                            destination);
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ]),
    );
  }
}
