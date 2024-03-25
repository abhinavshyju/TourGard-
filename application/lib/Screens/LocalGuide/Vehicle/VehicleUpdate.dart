import 'dart:io';

import 'package:application/Screens/Compents/DropDown.dart';
import 'package:application/Screens/Home/GuideHomePage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateVehicle extends StatefulWidget {
  const UpdateVehicle({super.key});

  @override
  State<UpdateVehicle> createState() => _UpdateVehicleState();
}

class _UpdateVehicleState extends State<UpdateVehicle> {
  TextEditingController _name = TextEditingController();
  File? _image1;
  File? _image2;
  String _typeofTransport = "";
  String _vehicleModel = "";

  Future<void> _uploadVehicleDetails(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final id = prefs.getInt("id");
    print(id);

    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final url = "$api/vehicle/upload";
    final dio = Dio();
    try {
      final FormData formData = FormData.fromMap({
        "id": id,
        "name": name,
        "typeoftrasport": _typeofTransport,
        "vehiclemodel": _vehicleModel,
        'image_one': await MultipartFile.fromFile(_image1!.path,
            filename: 'image_one.jpg'),
        'image_two': await MultipartFile.fromFile(_image2!.path,
            filename: 'image_two.jpg'),
      });
      final Response response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data == "pass") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GuideHomePage()));
        }
      } else {
        print("err");
      }
    } catch (e) {
      print(e);
    }
  }

  final picker = ImagePicker();

  Future getImage1FromGallery(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      }
    });
  }

  Future showOptions1() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImage1FromGallery(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImage1FromGallery(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  Future getImage2FromGallery(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      }
    });
  }

  Future showOptions2() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImage2FromGallery(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImage2FromGallery(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: const Color(0x40000000),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0)
          ],
          color: const Color(0xffffffff)),
      padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
      child: Column(
        children: [
          Row(
            children: [
              Text("Complete your profile",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w700,
                      fontFamily: "LexendDeca",
                      fontStyle: FontStyle.normal,
                      fontSize: 24.0),
                  textAlign: TextAlign.left),
            ],
          ),
          Row(
            children: [
              Text("Complete your profile by adding vehicle details",
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
          Row(
            children: [
              Text("Vehicle name : ",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                      fontFamily: "LexendDeca",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left),
            ],
          ),
          TextField(
            controller: _name,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text("Type of transport : ",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                      fontFamily: "LexendDeca",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          DropdownMenuExample(
              options: ["Two wheeler", "Four wheeler"],
              onSelectionChanged: (String value) {
                setState(() {
                  _typeofTransport = value;
                });
              }),
          Row(
            children: [
              Text("Vehicle Model: ",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                      fontFamily: "LexendDeca",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          DropdownMenuExample(
              options: ["Class A", "Class B", "Class C", "Class S"],
              onSelectionChanged: (String value) {
                setState(() {
                  _vehicleModel = value;
                });
              }),
          Row(
            children: [
              Text("Vehicle image :",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                      fontFamily: "LexendDeca",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left),
            ],
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: _image1 == null
                      ? Container(
                          margin: EdgeInsets.only(right: 20, top: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.grey)),
                          child: IconButton(
                            icon: const Icon(Icons.add_box_outlined, size: 100),
                            onPressed: showOptions1,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(right: 10, top: 20),
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(5),
                            image: DecorationImage(
                              image: FileImage(_image1!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(null),
                            onPressed: showOptions1,
                          ),
                        ),
                ),
                Container(
                  child: _image2 == null
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.grey)),
                          child: IconButton(
                            icon: const Icon(Icons.add_box_outlined, size: 100),
                            onPressed: showOptions2,
                          ),
                        )
                      : Container(
                          // margin: const EdgeInsets.only(top: 10),
                          width: 130,
                          height: 100,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(5),
                            image: DecorationImage(
                              image: FileImage(_image2!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(null),
                            onPressed: showOptions2,
                          ),
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x40000000),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0)
                ],
                color: Color.fromARGB(255, 0, 106, 255)),
            child: TextButton(
                onPressed: () {
                  String name = _name.text;
                  _vehicleModel != "" &&
                          name != "" &&
                          _typeofTransport != "" &&
                          _image1 != null &&
                          _image2 != null
                      ? _uploadVehicleDetails(name)
                      : print("select all");
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             LocalguideHomeScreen()));
                },
                child: Text(
                  "Update profile",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontFamily: "LexendDeca",
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0),
                )),
          )
        ],
      ),
    );
  }
}
