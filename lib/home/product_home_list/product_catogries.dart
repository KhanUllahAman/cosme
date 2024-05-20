import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/catogries/skincare.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';

import 'package:flutter/material.dart';
//
// class ProductCategories extends StatefulWidget {
//   const ProductCategories({Key? key}) : super(key: key);
//
//   @override
//   State<ProductCategories> createState() => _ProductCategoriesState();
// }
//
// class _ProductCategoriesState extends State<ProductCategories> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Types()));
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(left: 20),
//                   width: 150,
//                   height: 160,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                             blurRadius: 5,
//                             offset: Offset(1, 1),
//                             color: Colors.black26.withOpacity(0.5)),
//                       ],
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/cleanser7.png'))),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               BigText(
//                 color: Colors.black,
//                 text: 'Cleanser',
//                 size: 14,
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 10, right: 10),
//                 width: 150,
//                 height: 160,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 5,
//                           offset: Offset(1, 1),
//                           color: Colors.black26.withOpacity(0.5)),
//                     ],
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/mainmosturizer.png'))),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               BigText(
//                 color: Colors.black,
//                 text: 'Moisturizer',
//                 size: 14,
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 10, right: 10),
//                 width: 150,
//                 height: 160,
//                 decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 5,
//                           offset: Offset(1, 1),
//                           color: Colors.black26.withOpacity(0.5)),
//                     ],
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/Mask3.png'))),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               BigText(
//                 color: Colors.black,
//                 text: 'Mask',
//                 size: 14,
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 10, right: 10),
//                 width: 150,
//                 height: 160,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 5,
//                           offset: Offset(1, 1),
//                           color: Colors.black26.withOpacity(0.5)),
//                     ],
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/mainserum.png'))),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               BigText(
//                 color: Colors.black,
//                 text: 'Serum',
//                 size: 14,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProductCategories extends StatefulWidget {
  final String selectproducts;

  const ProductCategories({Key? key, required this.selectproducts})
      : super(key: key);

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  Future<List<Map<String, dynamic>>> _fetchProductlist(
      String catogeryName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Product')
        .doc(catogeryName)
        .collection('Productone')
        .get();

    final productList = querySnapshot.docs.map((doc) {
      final productName = doc.id;
      final imageURL =
          doc['imagepath']; // Assuming imageURL is the field in Firestore
      return {'name': productName, 'imagepath': imageURL};
    }).toList();

    print("My Debug: $productList");

    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchProductlist(widget.selectproducts),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final productList = snapshot.data!;
            return Row(
              children: productList.map((product) {
                final productName = product['name'];
                final imageURL = product['imagepath'];
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Types(
                                    clickedItemedName: widget.selectproducts,
                                    productId: '',
                                  )),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
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
                          image: DecorationImage(
                            image:
                                NetworkImage(imageURL), // Use fetched image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    BigText(
                      color: Colors.black,
                      text: productName, // Use fetched product name
                      size: 14,
                    ),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
