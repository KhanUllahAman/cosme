// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cosme/profile/profile_controller.dart';
// import 'package:cosme/utils/color.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/get_instance.dart';
//
// import '../model/user_model.dart';
//
// class feedback extends StatefulWidget {
//   const feedback({Key? key}) : super(key: key);
//
//   @override
//   State<feedback> createState() => _feedbackState();
// }
//
// class _feedbackState extends State<feedback> {
//   String Email = '';
//   double feedbackRating = 3.0; // Default rating value
//   final ProfileController profileController = Get.find();
//   TextEditingController commentController = TextEditingController();
//   // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   void saveFeedback() async {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final User? user = auth.currentUser;
//
//     if (user != null) {
//       final String uid = user.uid;
//
//       try {
//         FirebaseFirestore.instance.collection('feedback').doc(uid).set({
//           'rating': feedbackRating,
//           'comment': commentController.text,
//           'email': user.email,
//           'timestamp': FieldValue.serverTimestamp(),
//         });
//         // Show a success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Feedback sent successfully'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         // commentController.clear();
//         setState(() {
//           // feedbackRating = 3.0;
//           commentController.clear();
//         });
//         // Optionally, you can show a success message to the user here
//       } catch (e) {
//         print('Error saving feedback: $e');
//         // Show an error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error sending feedback. Please try again later.'),
//             duration: Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColor.mainColor,
//           title: Text('Feedback',
//               style: TextStyle(
//                   fontSize: 20,
//                   // fontWeight: FontWeight.bold,
//                   color: Colors.white)),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 60, top: 300),
//               child: FutureBuilder(
//                 // future: profileController.getUserData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasData) {
//                       UserModel user = snapshot.data as UserModel;
//
//                       Email = user.email;
//
//                       return SingleChildScrollView(
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 0),
//                           child: Column(
//                             children: [
//                               SizedBox(height: 15),
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(
//                                       8.0,
//                                     ), // Adjust the padding as needed
//
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(50.0),
//                                       border: Border.all(
//                                           color: Colors.white, width: 2.0),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Colors.blueGrey[600]!,
//                                           Colors.blue[400]!,
//                                         ],
//                                       ),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.email,
//                                           color: Colors.white,
//                                           size: 24.0,
//                                         ),
//                                         SizedBox(width: 8.0),
//                                         Text(
//                                           Email,
//                                           style: TextStyle(
//                                             fontSize:
//                                                 18.0, // Adjust font size as needed
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(right: 230),
//                                     child: Text('Rating',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black)),
//                                   ),
//                                   RatingBar.builder(
//                                     initialRating: feedbackRating,
//                                     minRating: 1,
//                                     direction: Axis.horizontal,
//                                     allowHalfRating: false,
//                                     itemCount: 5,
//                                     itemSize: 40,
//                                     itemPadding:
//                                         EdgeInsets.symmetric(horizontal: 5.0),
//                                     itemBuilder: (context, _) => Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     onRatingUpdate: (rating) {
//                                       setState(() {
//                                         feedbackRating = rating;
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(right: 200),
//                                 child: Text('Comment',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black)),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(right: 50),
//                                 child: Column(
//                                   children: [
//                                     Center(
//                                       child: TextField(
//                                         controller: commentController,
//                                         maxLength: 300,
//                                         maxLines: 5,
//                                         decoration: InputDecoration(
//                                           hintText:
//                                               'Share your thoughts and suggestions here',
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Colors.blue,
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                           ),
//                                           contentPadding: EdgeInsets.all(10),
//                                         ),
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10, right: 90),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     if (commentController.text.isNotEmpty) {
//                                       saveFeedback();
//                                       setState(() {
//                                         feedbackRating =
//                                             0; // Set it to your default rating
//                                         // commentController.clear();
//                                       });
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         SnackBar(
//                                           content: Text(
//                                               'Please enter a comment before sending.'),
//                                           duration: Duration(seconds: 3),
//                                         ),
//                                       );
//                                     }
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.blue[
//                                           800], // Changed background color to a darker blue
//                                       foregroundColor: Colors
//                                           .white, // Changed text color to white for better contrast
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 40,
//                                         vertical: 15,
//                                       ), // Adjusted padding for better proportions
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(
//                                             20.0), // Added rounded corners
//                                       ),
//                                       textStyle: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black)),
//                                   child: Text('Submit Feedback'),
//                                   // Changed text to be more descriptive and clear
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                   // Return a loading indicator or error message if needed
//                   return CircularProgressIndicator(); // Change this to suit your UI
//                 },
//               ),
//             ),
//           ],
//         ));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:cosme/widget/text%20and%20icon/small_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/color.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String email = '';
  double feedbackRating = 3.0; // Default rating value
  TextEditingController commentController = TextEditingController();

  void saveFeedback() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final String uid = user.uid;
      final String userName =
          user.displayName ?? ''; // Get user's display name if available

      try {
        await FirebaseFirestore.instance.collection('feedback').doc(uid).set({
          'userName': userName,
          'rating': feedbackRating,
          'comment': commentController.text,
          'email': user.email,
          'timestamp': FieldValue.serverTimestamp(),
        });
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Feedback sent successfully'),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() {
          commentController.clear();
        });
      } catch (e) {
        print('Error saving feedback: $e');
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending feedback. Please try again later.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Column(
        children: [
          Container(
            height: 210,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: AppColor.mainColor,
            ),
            child: Container(
              padding: (EdgeInsets.symmetric(horizontal: 50, vertical: 80)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: 'Hi Javeria',
                        color: Colors.white,
                      ),
                      SmallText(
                        text: 'Its time to add product to cart',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rating',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: feedbackRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      feedbackRating = rating;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Comment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: commentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter your feedback here',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      saveFeedback();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Please enter a comment before sending.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: Center(child: Text('Submit Feedback')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
