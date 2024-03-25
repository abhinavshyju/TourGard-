import 'package:flutter/material.dart';

class LocalGuideINfoINTraveller extends StatelessWidget {
  final String name;
  final String email;
  final String address;
  final int number;

  var image;

  LocalGuideINfoINTraveller({
    Key? key,
    required this.name,
    required this.email,
    required this.address,
    required this.number,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        color: Color(0xffffffff),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              border: Border.all(color: const Color(0xff00b796), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://qgbk7vxz-8000.inc1.devtunnels.ms$image"),
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name as String,
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(
                      address,
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "LexendDeca",
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  "$number",
                  style: TextStyle(
                    color: const Color(0xff2400ff),
                    fontWeight: FontWeight.w300,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: const Color(0xff2400ff),
                    fontWeight: FontWeight.w300,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
