import 'dart:io';

import 'package:application/Screens/Home/GuideHomePage.dart';
import 'package:application/Screens/LocalGuide/LocalguideFristpage.dart';
import 'package:application/Screens/TestPage.dart';
import 'package:application/Screens/Traveller/TravellerFirstScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocalGuideRegister extends StatefulWidget {
  const LocalGuideRegister({Key? key}) : super(key: key);

  @override
  State<LocalGuideRegister> createState() => _LocalGuideRegisterState();
}

class _LocalGuideRegisterState extends State<LocalGuideRegister> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File? _image;
  File? _document;

  bool? passValid = false;
  bool? imageValid = false;

  Future<void> sendPostRequest(
    String username,
    String name,
    String phone,
    String place,
    String password,
    File? image,
    File? document,
  ) async {
    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    // const String url = '$api/traveller/signup';
    try {
      final FormData formData = FormData.fromMap({
        'email': username,
        'name': name,
        'username': username,
        'phone': phone,
        'place': place,
        'password': password,
        'image':
            await MultipartFile.fromFile(image!.path, filename: 'image.jpg'),
        'document': await MultipartFile.fromFile(document!.path,
            filename: 'document.jpg'),
      });

      final Dio dio = Dio();
      final Response response = await dio.post(
        '$api/localguide/signup',
        data: formData,
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${(response.data['email'])}');

      if (response.statusCode == 200) {
        print('POST request successful');
        if (response.data["type"] == "guide") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', response.data['email']);
          prefs.setString('type', response.data['type']);
          prefs.setInt("id", response.data['id']);
          prefs.setInt("userid", response.data['userid']);

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GuideHomePage()));
        }
        // Handle the response as needed
      } else {
        print('POST request failed with status: ${response.statusCode}');
        // Handle the error response as needed
      }
    } catch (e) {
      if (e is DioError) {
        print('Dio error during POST request:');
        print('Error message: ${e.message}');
        print('Dio error type: ${e.type}');
        print('Dio error response: ${e.response}');
      } else {
        print('Unexpected error during POST request: $e');
      }
    }
  }

  final picker = ImagePicker();

  Future getImageFromGallery(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  Future getDocFromGallery(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _document = File(pickedFile.path);
      }
    });
  }

  Future showOptionsDoc() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getDocFromGallery(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getDocFromGallery(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
                colors: [Color(0xFF00FFD1), Color.fromARGB(255, 0, 0, 0)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Make your profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Lexend Deca',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Center(
                  child: _image == null
                      ? Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                "lib/assets/images/profileicon.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(null),
                            onPressed: showOptions,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 145,
                          height: 145,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 2,
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(null),
                            onPressed: showOptions,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  decoration: const BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15, bottom: 0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(193, 255, 255, 255)),
                          ),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(196, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15, bottom: 0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(193, 255, 255, 255)),
                          ),
                          hintText: 'Email Address',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(196, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _phoneController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15, bottom: 0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(193, 255, 255, 255)),
                          ),
                          hintText: 'Phone',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(196, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _placeController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15, bottom: 0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(193, 255, 255, 255)),
                          ),
                          hintText: 'Place',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(196, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextButton(
                          onPressed: showOptionsDoc,
                          child: const Text(
                            'Upload Passport or Adhaar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Lexend Deca',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      if (imageValid == true)
                        Text(
                          "Upload both profile and Id proof",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      const SizedBox(),
                      TextField(
                        controller: _passwordController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15, bottom: 0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(193, 255, 255, 255)),
                          ),
                          hintText: 'Set password',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(196, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _confirmPasswordController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15, bottom: 0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(193, 255, 255, 255)),
                          ),
                          hintText: 'Confirm password',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(196, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (passValid == true)
                        const Text(
                          "Password not match",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        )
                      else
                        SizedBox(),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Checkbox(
                            value: passValid,
                            onChanged: (value) {},
                          ),
                          const Text(
                            'I’ve read and agreed to the terms of use,\nprivacy notice and other details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Lexend Deca',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Terms of use, privacy notice and other details',
                        style: TextStyle(
                          color: Color(0xFF00FFD1),
                          fontSize: 10,
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            String username = _emailController.text;
                            String name = _nameController.text;
                            String phone = _phoneController.text;
                            String place = _placeController.text;

                            String password = _passwordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;

                            File? image = _image;
                            File? document = _document;

                            if (password == confirmPassword) {
                              setState(() {
                                passValid = false;
                              });
                              if (image != null && document != null) {
                                setState(() {
                                  imageValid = false;
                                });
                                if (password != "") {
                                  if (username != "" &&
                                      name != "" &&
                                      phone != "" &&
                                      place != "") {
                                    sendPostRequest(
                                      username,
                                      name,
                                      phone,
                                      place,
                                      password,
                                      image,
                                      document,
                                    );
                                  }
                                } else {
                                  print("fill pass");
                                  setState(() {
                                    passValid = true;
                                  });
                                }
                              } else {
                                // Show a message to the user indicating that both image and document are required.
                                print('Both image and document are required');
                                setState(() {
                                  imageValid = true;
                                });
                              }
                            } else {
                              setState(() {
                                passValid = true;
                              });
                              print(passValid);
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Lexend Deca',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
