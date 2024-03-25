import 'package:application/Screens/LocalguideRegister.dart';
import 'package:application/Screens/TravellerRegisterScreen.dart';
import 'package:flutter/material.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'What do you choose to be',
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
          height: 24,
        ),
        Container(
          width: 166,
          height: 38.70,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Traveller_Register(),
                  ),
                );
              },
              child: const Text(
                'Traveller',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Lexend Deca',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          width: 166,
          height: 38.70,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocalGuideRegister(),
                  ),
                );
              },
              child: const Text(
                'Local Guide',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Lexend Deca',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
        )
      ]),
    )));
  }
}
