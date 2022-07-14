import 'package:char_project/app/data/auth.dart';
import 'package:char_project/app/modules/Home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  logout() async {
    Get.defaultDialog(
        title: 'Alert',
        middleText: 'Do You Want SignOut',
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textConfirm: 'Yes',
        textCancel: 'No',
        onConfirm: () async {
          FirebaseAuth auth = FirebaseAuth.instance;
          await auth.signOut();
          Get.back();
          // await Get.offAll(HomeView());
        },
        onCancel: () {
          Get.off(HomeView());
        },
        buttonColor: Color.fromRGBO(22, 186, 197, 1),
        confirmTextColor: Colors.white);
  }

  String? myName = '';
  String? myProfilePic = '';
  String? myUserName = '';
  String? myEmail = '';
  getMySharedPreferenceName() async {
    myName = await Sharedpreference().getDisplayName();
    myEmail = await Sharedpreference().getUserEmail();
    myProfilePic = await Sharedpreference().getUserProfileUrl();
    myUserName = await Sharedpreference().getUserName();
    update();
  }
}
