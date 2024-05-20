// import 'package:cosme/FeedBack/feedback.dart';
// import 'package:cosme/Registeration_page.dart';
// import 'package:cosme/firebase_options.dart';
// import 'package:cosme/model/auth_controller.dart';
// import 'package:cosme/profile/profile.dart';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/get_core.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: registeration(),
//     );
//   }
// }

import 'package:cosme/FeedBack/feedback.dart';
import 'package:cosme/catogries/skincare.dart';
import 'package:cosme/home/product_home_list/product_details.dart';
import 'package:cosme/registeration/Registeration_page.dart';
import 'package:cosme/admin/admin_dashboard/dashboard.dart';
import 'package:cosme/admin/admin_categories/sub_sub_categories.dart';
import 'package:cosme/firebase_options.dart';
import 'package:cosme/home/product_home_list/product_home_lists.dart';
import 'package:cosme/registeration/login.dart';
import 'package:cosme/model/auth_controller.dart';
import 'package:cosme/profile/profile.dart';
import 'package:cosme/admin/admin_dashboard/bottom_navigation.dart';
import 'package:cosme/select_Type/select_type.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import 'admin/admin_dashboard/add_product.dart';
import 'home/Wishlist/Wishlist_allitem.dart';
import 'home/product_items.dart';
import 'mycart/add_to_cart.dart';
import 'profile/profile_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize ProfileController here
  Get.put(ProfileController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SelectType(),
    );
  }
}
