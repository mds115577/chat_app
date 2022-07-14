import 'package:char_project/app/data/databsae.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../chat_screen/views/chat_screen_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _homeController.logout();
              },
              icon: Icon(Icons.logout))
        ],
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List usersData = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            usersData.add(a);
            a["uid"] = document.id;
          }).toList();

          return ListView.separated(
            itemBuilder: (context, index) {
              final datas = usersData[index];

              // final dataimage = usersData[index]['image'];
              // var images = Base64Decoder().convert(dataimage);
              return Padding(
                padding: EdgeInsets.only(top: 8.0, left: 8, right: 8),
                child: Container(
                  height: 80,
                  child: auth.currentUser!.uid != datas['uid']
                      ? Card(
                          color: Color.fromARGB(120, 73, 118, 114),
                          child: ListTile(
                            onTap: () {
                              var chatRoomId = getChatRoomId(
                                  _homeController.myUserName!,
                                  datas['username']);
                              Map<String, dynamic> chatRoomInfoMap = {
                                "users": [
                                  _homeController.myUserName,
                                  datas['username']
                                ]
                              };
                              DatabseMethods()
                                  .createChatRoom(chatRoomId, chatRoomInfoMap);
                              Get.to(ChatScreenView(
                                data: datas,
                              ));
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(usersData[index]["imgUrl"],
                                  fit: BoxFit.cover),
                            ),
                            title: Text(
                              usersData[index]['name'],
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'E-mail:-${datas['email']}',
                              style: TextStyle(color: Colors.amber),
                            ),
                          ))
                      : Container(),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: usersData.length,
          );
        },
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b/_$a";
    } else {
      return "$a/_$b";
    }
  }
}
