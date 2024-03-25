import 'package:application/Model/Request.dart';
import 'package:application/Model/payment.dart';
import 'package:application/Screens/Compents/BottomNavBAr.dart';
import 'package:application/Screens/Compents/Drawer.dart';
import 'package:application/Screens/Compents/HometopSectiom.dart';
import 'package:application/Screens/Compents/guideBottomNavBar.dart';
import 'package:application/Screens/LocalGuide/LocalguideFristpage.dart';
import 'package:application/Screens/LocalGuide/RequestView/AcceptedRequestCard.dart';
import 'package:application/Screens/LocalGuide/TravellerRequestCared/TravellerRequestCard.dart';
import 'package:application/Screens/Traveller/AcceptedRequestView.dart';
import 'package:application/Screens/Traveller/ActiveRequestView.dart';
import 'package:application/Screens/Traveller/PaymentRequestCard.dart';
import 'package:application/Screens/Traveller/RequestCardTravellerView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingPaymentView extends StatefulWidget {
  const PendingPaymentView({super.key});

  @override
  State<PendingPaymentView> createState() => _PendingPaymentViewState();
}

class _PendingPaymentViewState extends State<PendingPaymentView> {
  Map<String, dynamic>? localguide;
  List<Payment> requests = [];

  @override
  void initState() {
    super.initState();
    // userCheck();
    getdata();
  }

  Future<void> getdata() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');
      await dotenv.load(fileName: "lib/.env");
      print(email);
      var api = dotenv.env["VAR_API"];
      final dio = Dio();
      final Response response =
          await dio.get("$api/request/traveller/pending/$email");

      setState(() {
        requests =
            paymentFromJson(response.data); // Add a single Request object
      });
      print(response.data);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      drawer: DrawerComp(),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
                color: const Color(0xff008870),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60, left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Notifications",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w900,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 36.0),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(14),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                    color: const Color(0xffffffff),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Complete payment",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w900,
                          fontFamily: "LexendDeca",
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 20),
                      requests.isNotEmpty
                          ? Column(
                              children: requests.map((item) {
                                return Column(
                                  children: [
                                    PaymentRequest(
                                        name: item.name,
                                        amount: item.payment.amount,
                                        id: item.payment.tripId,
                                        paymentid: item.payment.id,
                                        number: item.contact),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              }).toList(),
                            )
                          : Text("No request"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
