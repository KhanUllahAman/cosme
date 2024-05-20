import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/admin/admin_dashboard/dashboard.dart';
import 'package:cosme/admin/login/admin_login.dart';
import 'package:cosme/profile/profile.dart';
import 'package:cosme/registeration/Registeration_page.dart';
import 'package:cosme/utils/message.dart';
import 'package:cosme/widget/button/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/info_page.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _fire = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    // checkPer();
    super.initState();
  }

  void login() {
    setState(() {
      loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text.toString(),
    )
        .then((value) async {
      // Check if the user is authenticated
      if (value.user != null) {
        final userId = value.user!.uid;

        // Query Firestore to find the user with the provided email
        final userObj = await _fire
            .collection("Users")
            .where("Email", isEqualTo: emailController.text)
            .get();

        // Check if the query returned any documents
        if (userObj.docs.isNotEmpty) {
          final userRole = userObj.docs.first.data()["role"];
          if (userRole == "customer") {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (e) => Info()), (route) => false);
          } else if (userRole == "Admin") {
            // Handle the admin role
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (e) => AdminDashboard()),
                (route) => false);
          } else if (userRole == "new user") {
            // Handle the new user role
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (e) => Info()), (route) => false);
          } else {
            print("Unknown user role: $userRole");
          }
        } else {
          // Handle the case where no user is found with the provided email
          print("No user found with the provided email");
          Mmessage().toastMessage("No user found with the provided email");
        }

        setState(() {
          loading = false;
        });
      }
    }).onError((error, stackTrace) {
      debugPrint("Authentication error: $error");
      Mmessage().toastMessage("Authentication failed: $error");
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
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
                height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0XFFEC7D7F)),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/logo.png")))),
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
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
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
                                return null;
                              }),
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
                                if (value!.isEmpty) {
                                  return 'Enter password';
                                }
                                return null;
                              }),
                        ],
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  RoundButton(
                    title: 'Login',
                    loading: loading,
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          // MaterialPageRoute(
                          //     builder: (context) => forgetpassword(
                          //       selectRoute: widget.selectRoute,
                          //       fee: widget.fee,
                          //       // bus:widget.bus,
                          //     ))

                          // );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLogin()));
                        },
                        child: Text("Forgot password")),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                            MaterialPageRoute(
                                builder: (context) => registeration())
                            
                            );
                          },
                          child: Text("Sign up"))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
