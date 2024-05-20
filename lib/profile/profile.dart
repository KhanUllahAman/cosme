import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/home/info_page.dart';
import 'package:cosme/model/user_model.dart';
import 'package:cosme/profile/profile_controller.dart';
import 'package:cosme/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final ProfileController profileController = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isObscurePassword = true;

  File? profileImage;

  bool hasError = false;

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => Info(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: Container(
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;

                  final fullname = TextEditingController(text: user.fullname);
                  final userEmailController =
                      TextEditingController(text: user.email);

                  final phoneno = TextEditingController(text: user.phoneno);
                  final password = TextEditingController(text: user.password);
                  final confirmpassword =
                      TextEditingController(text: user.Confirmpassword);

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: profileImage != null
                                        ? FileImage(profileImage!)
                                            as ImageProvider // Use the selected image
                                        : AssetImage('assets/person_icon.png')
                                            as ImageProvider, // Fallback asset image
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 100, right: 10, bottom: 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    TextFormField(
                                      controller: fullname,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        hintText: 'Full name ',
                                        suffixIcon: Icon(Icons.edit),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: userEmailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        hintText: 'Email',
                                        suffixIcon: Icon(Icons.email),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: phoneno,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'phone no',
                                        suffixIcon: Icon(Icons.phone),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: password,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: 'password',
                                        suffixIcon: Icon(Icons.password),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final newEmail =
                                          userEmailController.text.trim();

                                      final updatedUserData = UserModel(
                                        fullname: fullname.text.trim(),
                                        email: newEmail,
                                        phoneno: phoneno.text.trim(),
                                        password: password.text.trim(),
                                        Confirmpassword:
                                            confirmpassword.text.trim(),
                                        role: '',
                                        // profileImageUrl: '',
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor,
                                      side: BorderSide.none,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Text(
                                      'Edit Profile',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
