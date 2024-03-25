import 'package:application/Screens/EntryScreen.dart';
import 'package:application/Screens/Home/TravellerHomePage.dart';
import 'package:application/Screens/Test/Test.dart';
import 'package:application/Screens/TestPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final String baseURl = "http://localhost:8000/";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        home:
            // TravellerHomePage()
            Scaffold(
          body: EntryScreen(),
          //   // body: TestPage(),
        ));
  }
}
