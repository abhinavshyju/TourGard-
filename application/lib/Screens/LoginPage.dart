import 'package:application/Screens/Home/GuideHomePage.dart';
import 'package:application/Screens/Home/TravellerHomePage.dart';
import 'package:application/Screens/LocalGuide/LocalguideFristpage.dart';
import 'package:application/Screens/TestPage.dart';
import 'package:application/Screens/Traveller/TravellerFirstScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> loginFun(username, password) async {
    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];

    try {
      final FormData formData =
          FormData.fromMap({'email': username, 'password': password});

      final Dio dio = Dio();
      final Response response = await dio.post(
        '$api/login',
        data: {"email": username, "password": password},
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${(response.data['email'])}');

      if (response.statusCode == 200) {
        print('POST request successful');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', response.data['email']);
        prefs.setString('type', response.data['type']);
        prefs.setInt('id', response.data['id']);
        prefs.setInt('userid', response.data['userid']);
        print(response.data['type']);
        if (response.data["type"] == "traveller") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TravellerHomePage()));
        } else {
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
                        colors: [
                          Color(0xFF00FFD1),
                          Color.fromARGB(255, 0, 0, 0)
                        ],
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Log in ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontFamily: 'Lexend Deca',
                                fontWeight: FontWeight.bold,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _email,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,
                                fontFamily: 'Lexend Deca',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 15, bottom: 0),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(193, 255, 255, 255)),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(196, 255, 255, 255),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _password,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,
                                fontFamily: 'Lexend Deca',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 15, bottom: 0),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(193, 255, 255, 255)),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(196, 255, 255, 255),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                                width: 200,
                                height: 30,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: ElevatedButton(
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Lexend Deca',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  onPressed: () {
                                    String username = _email.text;
                                    String password = _password.text;
                                    if (username != "" && password != "") {
                                      loginFun(username, password);
                                    }
                                  },
                                ))
                          ]),
                    )))));
  }
}
