import 'package:application/Screens/Compents/guideBottomNavBar.dart';
import 'package:application/Screens/Home/GuideHomePage.dart';
import 'package:application/Screens/LocalGuide/RequestView/AcceptRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPaymentAmount extends StatefulWidget {
  const AddPaymentAmount({super.key});

  @override
  State<AddPaymentAmount> createState() => _AddPaymentAmountState();
}

class _AddPaymentAmountState extends State<AddPaymentAmount> {
  TextEditingController _payment_amount = TextEditingController();
  Future<void> ProceedPayment(String amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final meid = prefs.getInt("id");
    final traveller_id = prefs.getInt("traveller_id");
    final trip_id = prefs.getInt("trip_id");
    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];

    final dio = Dio();
    var url = "$api/payment/";
    try {
      final Response response = await dio.post(url, data: {
        "traveller_login_id": traveller_id,
        "guide_login_id": meid,
        "trip_id": trip_id,
        "amount": amount
      });
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AcceptRequest()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      bottomNavigationBar: GuideBottomNavBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Payment amount",
            style: const TextStyle(
              color: const Color(0xff000000),
              fontWeight: FontWeight.w600,
              fontFamily: "LexendDeca",
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0)
              ],
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _payment_amount,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.currency_rupee),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                )),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () {
                        final String amount = _payment_amount.text;
                        amount != ""
                            ? ProceedPayment(amount)
                            : print("Enter amount");
                      },
                      child: Text(
                        "Set",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0)
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text("Travel Fair",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        fontFamily: "LexendDeca",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0),
                    textAlign: TextAlign.left),
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        BorderDirectional(top: BorderSide(color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 60, 10),
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                end: BorderSide(color: Colors.grey))),
                        child: Text("Selected Vehicle",
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.left)),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                end: BorderSide(color: Colors.grey))),
                        child: Text("1 KM",
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w800,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.center)),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                        decoration: BoxDecoration(),
                        child: Text("50",
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w800,
                                fontFamily: "LexendDeca",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.center)),
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
    ;
  }
}
