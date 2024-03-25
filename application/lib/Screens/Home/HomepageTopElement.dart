import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreenTopElement extends StatelessWidget {
  const HomeScreenTopElement({super.key});
  final String assetName = 'lib/assets/images/landing.svg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("TourGuard",
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w900,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 36.0),
                textAlign: TextAlign.left),
          ],
        ),
        Row(
          children: [
            Text("“Your Trusted Travel Companion”",
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w600,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
                textAlign: TextAlign.left),
          ],
        ),
        SvgPicture.asset(
          assetName,
          width: double.infinity,
          height: 200,
        ),
      ],
    );
  }
}
