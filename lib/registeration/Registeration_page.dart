import 'package:cosme/registeration/login.dart';
import 'package:cosme/utils/message.dart';
import 'package:cosme/widget/button/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../model/user_repository.dart';

class registeration extends StatefulWidget {
  const registeration({Key? key}) : super(key: key);

  @override
  State<registeration> createState() => _registerationState();
}

class _registerationState extends State<registeration> {
  bool loading = false;
  bool isFromValid = false;
  final _fromkey = GlobalKey<FormState>();
  final fullnameControlller = TextEditingController();
  final emailController = TextEditingController();
  final phonenoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  final userrepo = Get.put(UserRepository());
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Future<void> register() async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //         email: emailController.text.toString(),
  //         password: passwordController.text.toString());
  //     // Registration successful
  //     Mmessage().toastMessage("Registration successful");
  //     setState(() {
  //       loading = false;
  //     });
  //   } catch (error) {
  //     // Registration failed
  //     Mmessage().toastMessage(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  Future<void> register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
      // Registration successful
      Mmessage().toastMessage("Registration successful");
      setState(() {
        loading = false;
      });
    } catch (error) {
      // Registration failed
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          // Handle the case where the email is already in use
          Mmessage().toastMessage(
              "This email is already in use. Please use a different email.");
        } else {
          // Handle other authentication errors
          Mmessage().toastMessage("Registration failed: ${error.message}");
        }
      } else {
        // Handle other errors
        Mmessage().toastMessage("Registration failed: $error");
      }
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> createUser(UserModel user) async {
    await userrepo.createUser(user);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/background.jpg"),
            ),
          ),
        ),
        Center(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          width: 340,
          height: 580,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0XFFEC7D7F)),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png")))),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Paris Cosmetics",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                        key: _fromkey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: fullnameControlller,
                              decoration: const InputDecoration(
                                hintText: 'Full name',
                                suffixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter name';
                                }

                                // Update the regular expression to allow spaces
                                final RegExp nameRegex =
                                    RegExp(r'^[a-zA-Z ]{3,25}$');

                                if (!nameRegex.hasMatch(value)) {
                                  return 'Name should consist of only alphabetical characters and have 3 to 25 characters.';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: const InputDecoration(
                                    hintText: 'Email',
                                    suffixIcon: Icon(Icons.alternate_email)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter email';
                                  }
                                  // Define a regular expression to match the email format.
                                  final RegExp emailRegExp = RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                                  if (!emailRegExp.hasMatch(value)) {
                                    return 'Invalid email address format';
                                  }

                                  return null;
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: phonenoController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: 'XXXX-XXXXXXX',
                                suffixIcon: Icon(Icons.add_call),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter phone no';
                                }

                                // Define a regular expression to match the phone number format.
                                final RegExp phoneRegExp =
                                    RegExp(r'^\d{4}-\d{7}$');

                                if (!phoneRegExp.hasMatch(value)) {
                                  return 'Invalid phone number format. Use XXXX-XXXXXXX';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: 'password',
                                    suffixIcon: Icon(Icons.lock_open)),
                                validator: (value) {
                                  // if (value!.isEmpty) {
                                  //   return 'Enter password';
                                  // }
                                  // final RegExp passwordRegExp = RegExp(
                                  //     r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

                                  // if (!passwordRegExp.hasMatch(value)) {
                                  //   return 'Password must contain at least 8 characters with \n alphabets, numbers, and special characters';
                                  // }
                                  // return null;
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: confirmpasswordController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: ' Confirm password',
                                    suffixIcon: Icon(Icons.lock_open)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Reenter password';
                                  }

                                  // Check if the password matches the value in the password field.
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }

                                  return null;
                                }),
                          ],
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    RoundButton(
                      title: 'Create Account',
                      loading: loading,
                      // onTap: () {
                      //   if (_fromkey.currentState!.validate()) {
                      //     isFromValid = true;
                      //
                      //     final user = UserModel(
                      //       fullname: fullnameControlller.text.trim(),
                      //       email: emailController.text.trim(),
                      //       password: passwordController.text.trim(),
                      //       Confirmpassword:
                      //           confirmpasswordController.text.trim(),
                      //       role: 'customer',
                      //       phoneno: phonenoController.text.trim(),
                      //     );
                      //
                      //     register();
                      //     UserRepository.instance.createUser(user);
                      //
                      //     // Corrected the line here
                      //   }
                      //
                      //   if (isFromValid) {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) => login()));
                      //   }
                      // },

                      onTap: () async {
                        if (_fromkey.currentState!.validate()) {
                          isFromValid = true;

                          final user = UserModel(
                            fullname: fullnameControlller.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            Confirmpassword:
                                confirmpasswordController.text.trim(),
                            role: 'customer',
                            phoneno: phonenoController.text.trim(),
                          );

                          // Register the user using Firebase authentication
                          await register();

                          if (isFromValid) {
                            // Store user data in Firestore
                            await UserRepository.instance.createUser(user);

                            // Navigate to the login screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => login()),
                            );
                          }
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            },
                            child: Text("Login"))
                      ],
                    )
                  ],
                )
              ]))
            ],
          ),
        ))
      ]),
    );
  }
}
