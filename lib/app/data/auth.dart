import 'package:char_project/app/data/databsae.dart';
import 'package:char_project/app/modules/Home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User userDetails = result.user!;
    Sharedpreference().saveUserEmail(userDetails.email!);
    Sharedpreference().saveUserId(userDetails.uid);
    Sharedpreference().saveUserDisplay(userDetails.displayName!);
    Sharedpreference().saveUserProfile(userDetails.photoURL!);
    Sharedpreference()
        .saveUserName(userDetails.email!.replaceAll("@gmail.com", ''));
    Map<String, dynamic> userInfoMap = {
      "email": userDetails.email,
      "username": userDetails.email!.replaceAll("@gmail.com", ""),
      "name": userDetails.displayName,
      "imgUrl": userDetails.photoURL
    };

    await DatabseMethods()
        .addUserInfoToDb(userDetails.uid, userInfoMap)
        .then((value) {
      Get.to(HomeView());
    });
  }
}

class Sharedpreference {
  static String userID = "USERKEY";
  static String userName = "USERNAMEKEY";
  static String displayName = "USERDISPLAYKEY";
  static String userEmail = "USEREMAILKEY";
  static String userProfilePic = "USERPROFILEPICKEY";

  saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userName, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmail, getUserEmail);
  }

  saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userID, getUserId);
  }

  Future<bool> saveUserDisplay(String getUserDisplay) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayName, getUserDisplay);
  }

  Future<bool> saveUserProfile(String getUserProfilePic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePic, getUserProfilePic);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmail);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userID);
  }

  Future<String?> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayName);
  }

  Future<String?> getUserProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePic);
  }
}
