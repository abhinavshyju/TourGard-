import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenTopSection extends StatelessWidget {
  final name;
  final email;
  final place;
  final image;

  const HomeScreenTopSection(
      {super.key,
      required this.name,
      required this.email,
      required this.place,
      required this.image});

  @override
  Widget build(BuildContext context) {
    var imageUrl = "https://qgbk7vxz-8000.inc1.devtunnels.ms$image" ??
        "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png";
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(27),
                    bottomRight: Radius.circular(27)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x40000000),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0)
                ],
                color: const Color(0xff008870))),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.green.withOpacity(0),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                width: double.infinity,
                height: 175,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    // ignore: unnecessary_const
                    color: const Color(0xffffffff)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 18),
                            textAlign: TextAlign.start),
                        SizedBox(
                          height: 8,
                        ),
                        Text(email,
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 17),
                            textAlign: TextAlign.start),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text(place,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "LexendDeca",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16),
                                textAlign: TextAlign.start),
                          ],
                        )
                      ],
                    ),
                    Container(
                        height: 100,
                        width: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(
                              color: const Color(0xff00b796), width: 2),
                          boxShadow: [
                            const BoxShadow(
                                color: Color(0x40000000),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
