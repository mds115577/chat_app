import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  final firstNameEditingController = TextEditingController();
  final ageediting = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  File? image;
  String img = '';
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      img = base64Encode(bytes);
    }
    update();
  }
}
