import 'dart:async';
import 'dart:math';

import 'package:application/Model/Message.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      getMessage();
    });
    getMessage();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  TextEditingController _message_text = TextEditingController();
  var meid;
  List<Message> message = [];

  Future getMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reciver_id = prefs.getInt("guide_id");
    final sender_id = prefs.getInt("id");
    // print({"me": sender_id, "you": reciver_id});

    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final url = "$api/message/get";
    try {
      final Response response = await dio.post(url, data: {
        "sender_id": sender_id,
        "reciver_id": reciver_id,
      });
      if (response.statusCode == 200) {
        setState(() {
          meid = sender_id;
          message = messageFromJson(response.data);
        });
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendmessage(String textmessage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reciver_id = prefs.getInt("guide_id");
    final sender_id = prefs.getInt("id");

    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final url = "$api/message";
    try {
      final Response response = await dio.post(url, data: {
        "sender_id": sender_id,
        "reciver_id": reciver_id,
        "message": textmessage
      });
      if (response.statusCode == 200) {
        getMessage();
        _message_text.clear();
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    return Scaffold(
      body: Column(
        children: [
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
                  spreadRadius: 0,
                )
              ],
              color: Color(0xffffffff),
            ),
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
                  ),
                ),
                const Text(
                  "Chat",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 50),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                if (message.isNotEmpty)
                  ...message.map(
                    (e) => BubbleNormal(
                      text: e.message,
                      isSender: e.senderId == meid,
                      color: e.senderId == meid
                          ? Color(0xFF1B97F3)
                          : Color.fromARGB(101, 168, 195, 215),
                      tail: true,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: e.senderId == meid ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                if (message.isEmpty)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 3, 20, 3),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0)
                ],
                borderRadius: BorderRadius.circular(90)),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _message_text,
                  decoration: InputDecoration(
                    hintText: "Message",
                    border: InputBorder.none,
                  ),
                )),
                IconButton(
                    onPressed: () {
                      final textmessage = _message_text.text;
                      textmessage.isNotEmpty
                          ? sendmessage(textmessage)
                          : print("enter text");
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
