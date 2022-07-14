import 'package:char_project/app/data/auth.dart';
import 'package:char_project/app/data/databsae.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

import '../controllers/chat_screen_controller.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  final data;
  String chatRoomId = '';
  String messageId = '';
  String? myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageTextEditingController = TextEditingController();
  ChatScreenView({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
        centerTitle: true,
      ),
      body: Container(
          child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextEditingController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'type a message'),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  getMySharedPreferenceName() async {
    myName = await Sharedpreference().getDisplayName();
    myEmail = await Sharedpreference().getUserEmail();
    myProfilePic = await Sharedpreference().getUserProfileUrl();
    myUserName = await Sharedpreference().getUserName();

    chatRoomId = getChatRoomId(data['username'], myUserName!);
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b/_$a";
    } else {
      return "$a/_$b";
    }
  }

  getAndSetMessages() {}

  doThisOnLaunch() async {
    await getMySharedPreferenceName();
    getAndSetMessages();
  }

  addMessage(bool sendClick) {
    if (messageTextEditingController.text != '') {
      String message = messageTextEditingController.text;
      var lastMessageTs = DateTime.now();
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": lastMessageTs,
        "imgUrl": myProfilePic
      };
      if (messageId == '') {
        messageId = randomAlphaNumeric(12);
      }
      DatabseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserName
        };
        DatabseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);
      });
    }
  }
}
