import 'package:application/Screens/Home/TravellerHomePage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TextEditingController _report = TextEditingController();
  Future<void> sendReport(String report) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final report_id = prefs.getInt("report_id");
    final sender_id = prefs.getInt("id");

    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final url = "$api/report";
    try {
      final Response response = await dio.post(url, data: {
        "report": report,
        "reporter_id": sender_id,
        "report_id": report_id
      });
      if (response.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TravellerHomePage()));
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Report Local Guide",
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w900,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 36.0),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _report,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter the report",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: const Color.fromARGB(255, 61, 58, 58)))),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    String report = _report.text;
                    if (report != "") {
                      sendReport(report);
                    }
                  },
                  child: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Report",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.send)
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
