import 'package:application/Screens/Home/GuideHomePage.dart';
import 'package:application/Screens/Home/TravellerHomePage.dart';
import 'package:application/Screens/LocalGuide/LocalguideFristpage.dart';
import 'package:application/Screens/LoginPage.dart';
import 'package:application/Screens/RoleScreen.dart';
import 'package:application/Screens/TestPage.dart';
import 'package:application/Screens/Traveller/TravellerFirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MaterialApp(
    home: EntryScreen(),
  ));
}

class EntryScreen extends StatelessWidget {
  const EntryScreen({Key? key}) : super(key: key);

  Future<void> _lofginCheck(context) async {
    final String traveller = "traveller";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? type = prefs.getString('type');
    if (email != null) {
      if (type == traveller) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TravellerHomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GuideHomePage()));
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoleScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //  double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1],
              colors: [Color(0xFF00FFD1), Color.fromARGB(255, 0, 0, 0)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                const Column(
                  children: [
                    Image(
                      image: AssetImage('lib/assets/images/logo.png'),
                      height: 300,
                      width: 300,
                    ),
                    Text(
                      "TourGuard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Text(
                      '“Your Trusted Travel Companion”',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 173,
                  height: 40.34,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _lofginCheck(context);
                    },
                    child: const Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a user?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00FFD1),
                              fontSize: 16,
                              fontFamily: 'Lexend Deca',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
