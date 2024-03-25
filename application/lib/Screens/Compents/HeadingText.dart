import 'package:flutter/cupertino.dart';

class HeadingText extends StatelessWidget {
  final String title;

  // Corrected constructor
  const HeadingText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Color(0xff000000),
          fontWeight: FontWeight.bold,
          fontFamily: "LexendDeca",
          fontStyle: FontStyle.normal,
          fontSize: 18),
      textAlign: TextAlign.left,
    );
  }
}
