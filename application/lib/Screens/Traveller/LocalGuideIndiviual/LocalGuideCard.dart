import 'package:application/Screens/Traveller/LocalGuideInduvidual.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class GuideCard extends StatefulWidget {
  var name;

  var image;

  var place;

  var id;

  var guide_id;
  GuideCard(
      {super.key,
      required this.name,
      required this.image,
      required this.place,
      required this.id,
      required this.guide_id});

  @override
  State<GuideCard> createState() => _GuideCardState();
}

class _GuideCardState extends State<GuideCard> {
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('guidid', widget.id);
    prefs.setInt('guide_id', widget.guide_id);
  }

  @override
  Widget build(BuildContext context) {
    var imageUrl = "https://qgbk7vxz-8000.inc1.devtunnels.ms${widget.image}" ??
        "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png";
    return Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(
                        color: const Color(0xff00b796),
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name, // Accessing name using widget.name
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "LexendDeca",
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                          ),
                          Text(
                            widget.place,
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "LexendDeca",
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  saveData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocalGuideIndividualScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Choose",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w400,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
