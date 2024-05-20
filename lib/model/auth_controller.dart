import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/info_page.dart';
import '../registeration/login.dart';

// class AuthController extends GetxController {
//   //auth instance
//   final AuthController instance = Get.find();
//   //email,password ...
//   late Rx<User?> user;
//   //firebase auth
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   @override
//   void onReady() {
//     super.onReady();
//     user = Rx<User?>(auth.currentUser);
//     // our user would be notified
//     user.bindStream(auth.userChanges());
//     ever(user, _initialScreen);
//   }
//
//   _initialScreen(User? _user) {
//     //if user is not log in then
//     if (_user == null) {
//       print("login page");
//       Get.offAll(() => login());
//     } else {
//       Get.offAll(() => Info());
//     }
//     //if user is log in
//   }
//
//   void register(String email, password, String role) {
//     try {
//       auth.createUserWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       Get.snackbar("About User", "User message",
//           backgroundColor: Colors.black26,
//           snackPosition: SnackPosition.BOTTOM,
//           titleText: Text(
//             "Account creation failed",
//             style: TextStyle(color: Colors.white),
//           ),
//           messageText: Text(
//             e.toString(),
//           ));
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/info_page.dart';
import '../registeration/login.dart';

class AuthController extends GetxController {
  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  void _initialScreen(User? _user) {
    if (_user == null) {
      Get.offAll(() => login());
    } else {
      Get.offAll(() => Info());
    }
  }

  void register(String email, String password, String role) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Account Creation Failed",
        e.toString(),
        backgroundColor: Colors.black26,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }
}
