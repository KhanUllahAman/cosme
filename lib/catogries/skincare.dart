import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/widget/text%20and%20icon/app_icon.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:cosme/widget/text%20and%20icon/small_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../home/product_home_list/product_details.dart';
import '../utils/color.dart';

// class Types extends StatefulWidget {
//   final String clickedItemedName;
//   const Types({Key? key, required this.clickedItemedName}) : super(key: key);
//
//   @override
//   State<Types> createState() => _TypesState();
// }
//
// class _TypesState extends State<Types> {
//   Future<List<QueryDocumentSnapshot>> _fetchSubCategories() async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('ClickedItems')
//         .doc(widget.clickedItemedName)
//         .collection('Items')
//         .get();
//
//     final productList = querySnapshot.docs.toList();
//     print("My debug: $productList");
//
//     return productList;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSubCategories();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<QueryDocumentSnapshot>>(
//         future: _fetchSubCategories(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No Data Available'));
//           } else {
//             final pDataList = snapshot.data!;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     ),
//                     color: AppColor.mainColor,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         AppIcon(
//                           icon: Icons.arrow_back_ios,
//                           ontap: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         badges.Badge(
//                           position: badges.BadgePosition.topEnd(
//                             top: -8,
//                             end: -14,
//                           ),
//                           badgeContent: Text(
//                             '72',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontStyle: FontStyle.italic,
//                               fontSize: 12,
//                             ),
//                           ),
//                           onTap: () {},
//                           badgeAnimation: badges.BadgeAnimation.rotation(
//                             animationDuration: Duration(seconds: 6),
//                             colorChangeAnimationDuration: Duration(seconds: 2),
//                             loopAnimation: false,
//                             curve: Curves.fastOutSlowIn,
//                             colorChangeAnimationCurve: Curves.easeInCubic,
//                           ),
//                           badgeStyle: badges.BadgeStyle(
//                             shape: badges.BadgeShape.circle,
//                             badgeColor: Colors.blue,
//                             padding: EdgeInsets.all(5),
//                             borderRadius: BorderRadius.circular(4),
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: 2),
//                             borderGradient: badges.BadgeGradient.linear(
//                               colors: [Colors.red, Colors.deepOrange],
//                             ),
//                             badgeGradient: badges.BadgeGradient.linear(
//                               colors: [Colors.deepOrange, AppColor.mainColor],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ),
//                             elevation: 0,
//                           ),
//                           child: AppIcon(
//                             icon: Icons.shopping_cart,
//                             ontap: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   margin: EdgeInsets.only(left: 20, right: 20),
//                   width: 300,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Colors.grey[100],
//                   ),
//                   child: Row(
//                     children: [
//                       SizedBox(width: 10),
//                       AppIcon(icon: Icons.search),
//                       SizedBox(width: 20),
//                       SmallText(
//                         text: 'Search Product',
//                         color: Colors.grey[400],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: pDataList.length,
//                     itemBuilder: (context, index) {
//                       final document = pDataList[index];
//                       final pName = document.id;
//                       final name = document.get('name');
//                       final description = document.get('description');
//                       final price = document.get('price');
//                       return Row(
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 10),
//                                 width: 150,
//                                 height: 160,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       blurRadius: 5,
//                                       offset: Offset(1, 1),
//                                       color: Colors.black26.withOpacity(0.5),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               ProductItemDescription(),
//                                         ),
//                                       );
//                                     },
//                                     child: Column(
//                                       children: [
//                                         Image(
//                                           height: 120,
//                                           image: AssetImage(
//                                               'assets/images/lipstick.png'),
//                                         ),
//                                         BigText(
//                                           color: Colors.black,
//                                           text: name,
//                                           size: 16,
//                                         ),
//                                         SmallText(
//                                           text: "Rs:$price",
//                                           color: AppColor.mainColor,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 10),
//                                   height: 30,
//                                   width: 90,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                         color: AppColor.mainColor, width: 3),
//                                   ),
//                                   child: Center(
//                                     child: BigText(
//                                       text: 'Add to cart',
//                                       size: 13,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }

class Types extends StatefulWidget {
  final String clickedItemedName;
  final String productId;

  const Types(
      {Key? key, required this.clickedItemedName, required this.productId})
      : super(key: key);

  @override
  State<Types> createState() => _TypesState();
}

class _TypesState extends State<Types> {
  Future<List<QueryDocumentSnapshot>> _fetchSubCategories() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('ClickedItems')
        .doc(widget.clickedItemedName)
        .collection('Items')
        .get();

    final productList = querySnapshot.docs.toList();
    print("My debug: $productList");

    return productList;
  }

  Future<String> getDynamicProductId(String clickedItemedName) async {
    try {
      // Fetch the document containing the product ID
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('ClickedItems')
          .doc(clickedItemedName)
          .collection('Items')
          .doc()
          .get(); // Use appropriate document ID fetching logic here

      // Extract product ID from the document snapshot
      String productId = productSnapshot.id;

      return productId;
    } catch (e) {
      print('Error fetching product ID: $e');
      // Handle error
      return ''; // Return an empty string or any default value
    }
  }

  void addToCart(String productName, double price) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Access Firestore collection for the user's cart
        CollectionReference cartCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart');

        // Add product details to the cart
        await cartCollection.add({
          'productName': productName,
          'price': price,
          'userName': user.displayName,
          'userEmail': user.email,
          'userPhoneNumber': user.phoneNumber,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print('Product added to cart successfully!');
      } else {
        // User is not authenticated, handle accordingly
        print('User not authenticated');
      }
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchSubCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No Data Available'));
          } else {
            final pDataList = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: AppColor.mainColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppIcon(
                          icon: Icons.arrow_back_ios,
                          ontap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        badges.Badge(
                          position: badges.BadgePosition.topEnd(
                            top: -8,
                            end: -14,
                          ),
                          badgeContent: Text(
                            '72',
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                          onTap: () {},
                          badgeAnimation: badges.BadgeAnimation.rotation(
                            animationDuration: Duration(seconds: 6),
                            colorChangeAnimationDuration: Duration(seconds: 2),
                            loopAnimation: false,
                            curve: Curves.fastOutSlowIn,
                            colorChangeAnimationCurve: Curves.easeInCubic,
                          ),
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.circle,
                            badgeColor: Colors.blue,
                            padding: EdgeInsets.all(5),
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderGradient: badges.BadgeGradient.linear(
                              colors: [Colors.red, Colors.deepOrange],
                            ),
                            badgeGradient: badges.BadgeGradient.linear(
                              colors: [Colors.deepOrange, AppColor.mainColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            elevation: 0,
                          ),
                          child: AppIcon(
                            icon: Icons.shopping_cart,
                            ontap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      AppIcon(icon: Icons.search),
                      SizedBox(width: 20),
                      SmallText(
                        text: 'Search Product',
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: pDataList.length,
                    itemBuilder: (context, index) {
                      final document = pDataList[index];
                      final pName = document.id;
                      final name = document.get('name');
                      final description = document.get('description');
                      final price = document.get('price');
                      return Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: 150,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(1, 1),
                                      color: Colors.black26.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      String productId =
                                          await getDynamicProductId(
                                              widget.clickedItemedName);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                            clickedItemedName:
                                                widget.clickedItemedName,
                                            productId: productId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Image(
                                          height: 120,
                                          image: AssetImage(
                                              'assets/images/lipstick.png'),
                                        ),
                                        BigText(
                                          color: Colors.black,
                                          text: name,
                                          size: 16,
                                        ),
                                        SmallText(
                                          text: "Rs:$price",
                                          color: AppColor.mainColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  addToCart(name, price);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor.mainColor, width: 3),
                                  ),
                                  child: Center(
                                    child: BigText(
                                      text: 'Add to cart',
                                      size: 13,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
