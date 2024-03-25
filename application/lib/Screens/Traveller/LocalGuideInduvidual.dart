import 'package:application/Model/Guide.dart';
import 'package:application/Model/Vehicle.dart';
import 'package:application/Screens/Chat/chatScreen.dart';
import 'package:application/Screens/Compents/HeadingText.dart';
import 'package:application/Screens/Home/TravellerHomePage.dart';
import 'package:application/Screens/Traveller/LocalGuideIndiviual/LgIInfoSection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalGuideIndividualScreen extends StatefulWidget {
  const LocalGuideIndividualScreen({super.key});

  @override
  State<LocalGuideIndividualScreen> createState() =>
      _LocalGuideIndividualScreenState();
}

class _LocalGuideIndividualScreenState
    extends State<LocalGuideIndividualScreen> {
  @override
  Guide? guide;
  Vehicle? vehicle;
  void initState() {
    // TODO: implement initState
    getdata();
    getVehicle();
    super.initState();
  }

  Future<void> getVehicle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getInt('guidid');

    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final url = "$api/vehicle/get";
    try {
      final Response response = await dio.post(url, data: {"id": id});
      if (response.statusCode == 200) {
        if (response.data != null && response.data.isNotEmpty) {
          setState(() {
            vehicle = vehicleFromJson(response.data);
          });
          print(response.data);
        } else {
          // Handle case when response data is empty or not valid
          print("No vehicle data found");
          setState(() {
            vehicle = null;
          });
        }
      } else {
        // Handle other status codes if needed
        print(
            "Failed to fetch vehicle data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pickuplocation = prefs.getString('currentlocation');
    var contact = prefs.getString("constact");
    var email = prefs.getString("email");
    var guideId = prefs.getInt('guidid');
    var id = prefs.getInt("id");

    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    try {
      final dio = Dio();
      final sent = await dio.post(
        '$api/request',
        data: {
          "email": email,
          "contact": contact,
          "pickuplocation": pickuplocation,
          "localguideid": guideId
        },
      );
      print(sent);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TravellerHomePage()));
    } catch (e) {
      print(e);
    }
  }

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('guidid');
    print(id);

    try {
      await dotenv.load(fileName: "lib/.env");
      var api = dotenv.env["VAR_API"];
      final dio = Dio();
      final response = await dio.get("$api/localguide/user/$id");
      setState(() {
        guide = Guide.fromJson(response.data);
      });
      print(response.data);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 40, 18, 18),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.keyboard_backspace,
                    size: 26,
                  )),
              const Text("Profile Details",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.bold,
                      fontFamily: "LexendDeca",
                      fontStyle: FontStyle.normal,
                      fontSize: 24),
                  textAlign: TextAlign.left),
              const SizedBox()
            ],
          )),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            if (guide != null)
              LocalGuideINfoINTraveller(
                name: guide!.name,
                address: guide!.place,
                email: guide!.email,
                number: guide!.phone,
                image: guide!.imageFile,
              )
            else
              CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingText(title: "Vehicle"),
                  SizedBox(
                    height: 10,
                  ),
                  vehicle != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Image(
                                        image: NetworkImage(
                                            "https://qgbk7vxz-8000.inc1.devtunnels.ms${vehicle?.vehicleImageOne}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Image(
                                        image: NetworkImage(
                                            "https://qgbk7vxz-8000.inc1.devtunnels.ms${vehicle?.vehicleImageTwo}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("${vehicle?.name}",
                                style: const TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "LexendDeca",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18.0),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 50,
                            ),
                            Text("Rating",
                                style: const TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "LexendDeca",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0),
                                textAlign: TextAlign.left),
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        )
                      : CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final id = prefs.getInt("id");
                    final guideid = prefs.getInt("guide_id");
                    print(guideid);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  child: Text(
                    "Message",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {
                    sendRequest();
                  },
                  child: Text(
                    "Choose",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      )
    ]));
  }
}
