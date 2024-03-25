import 'package:application/Screens/Compents/HeadingText.dart';
import 'package:flutter/cupertino.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Color(0x40000000),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0)
          ],
          color: Color(0xffffffff)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingText(title: "Vehicle"),
          Row(
            children: [
              Container(
                  width: double.infinity,
                  child:
                      Image(image: AssetImage('lib/assets/images/logo.png'))),
            ],
          )
        ],
      ),
    );
  }
}
