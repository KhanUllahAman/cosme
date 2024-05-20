import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/catogries/skincare.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:flutter/material.dart';
import '../../utils/color.dart';

//
//       ListView.builder(
//           shrinkWrap: true,
//           itemCount: mainProductDataList.length,
//           itemBuilder: (context, index) {
//             final categoryName = mainProductDataList[index];
//             return Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   BigText(text: categoryName, size: 16),
//                   ProductCategories(
//                     selectproducts: '',
//                   ),
//                 ],
//               ),
//             );
//           }),
//
//       SizedBox(
//         height: 20,
//       ),
//       //     Padding(
//       //       padding: const EdgeInsets.only(left: 20),
//       //       child: Column(
//       //         children: [BigText(text: 'Makeup', size: 16)],
//       //       ),
//       // )
//     ]);
//   }
// }

//         ProductCategories(),
//
//         SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: Column(
//             children: [BigText(text: 'Hair ', size: 16)],
//           ),
//         ),
//         // SingleChildScrollView(
//         //   scrollDirection: Axis.horizontal,
//         //   child: Row(
//         //     children: [
//         //       Column(
//         //         children: [
//         //           Container(
//         //             margin: EdgeInsets.only(left: 20),
//         //             width: 150,
//         //             height: 160,
//         //             decoration: BoxDecoration(
//         //                 color: Colors.white,
//         //                 borderRadius: BorderRadius.circular(10),
//         //                 boxShadow: [
//         //                   BoxShadow(
//         //                       blurRadius: 5,
//         //                       offset: Offset(1, 1),
//         //                       color: Colors.black26.withOpacity(0.5)),
//         //                 ],
//         //                 image: DecorationImage(
//         //                     image: AssetImage('assets/images/hair.png'))),
//         //           ),
//         //           SizedBox(
//         //             height: 10,
//         //           ),
//         //           BigText(
//         //             color: Colors.black,
//         //             text: 'Shampoo',
//         //             size: 14,
//         //           ),
//         //         ],
//         //       ),
//         //       Column(
//         //         children: [
//         //           Container(
//         //             margin: EdgeInsets.only(left: 10, right: 10),
//         //             width: 150,
//         //             height: 160,
//         //             decoration: BoxDecoration(
//         //                 color: Colors.white,
//         //                 borderRadius: BorderRadius.circular(10),
//         //                 boxShadow: [
//         //                   BoxShadow(
//         //                       blurRadius: 5,
//         //                       offset: Offset(1, 1),
//         //                       color: Colors.black26.withOpacity(0.5)),
//         //                 ],
//         //                 image: DecorationImage(
//         //                     image: AssetImage('assets/images/hairoil.png'))),
//         //           ),
//         //           SizedBox(
//         //             height: 10,
//         //           ),
//         //           BigText(
//         //             color: Colors.black,
//         //             text: 'Hair Oil',
//         //             size: 14,
//         //           ),
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         ProductCategories(),
//         SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: Column(
//             children: [BigText(text: 'Makeup', size: 16)],
//           ),
//         ),
//
//         ProductCategories(),
//       ],
//     );
//   }
// }

// class ProductListItem extends StatefulWidget {
//   const ProductListItem({Key? key}) : super(key: key);
//
//   @override
//   State<ProductListItem> createState() => _ProductListItemState();
// }
//
// class _ProductListItemState extends State<ProductListItem> {
//   List<String> mainProductDataList = [];
//
//   Future<void> _fetchProduct() async {
//     final productQuery =
//         await FirebaseFirestore.instance.collection('Product').get();
//
//     setState(() {
//       mainProductDataList = productQuery.docs.map((doc) => doc.id).toList();
//     });
//     print("My Debug: $mainProductDataList");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProduct();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 190),
//           child: Container(
//             margin: EdgeInsets.only(left: 20, right: 20),
//             width: 300,
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               color: Colors.grey[100],
//             ),
//             child: Row(
//               children: [
//                 SizedBox(width: 10),
//                 Icon(Icons.search),
//                 SizedBox(width: 20),
//                 Text(
//                   'Search Product',
//                   style: TextStyle(color: Colors.grey[400]),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: Container(
//             margin: EdgeInsets.only(left: 20, right: 50),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Popular Product',
//                   style: TextStyle(color: AppColor.mainColor),
//                 ),
//                 Text(
//                   'See All',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 10),
//         SizedBox(
//           height:
//               MediaQuery.of(context).size.height, // Adjust the height as needed
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: mainProductDataList.length,
//             itemBuilder: (context, index) {
//               final categoryName = mainProductDataList[index];
//               SizedBox(
//                 height: 20,
//               );
//               return Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       categoryName,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     FutureBuilder<List<Map<String, dynamic>>>(
//                       future: _fetchProductList(categoryName),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         } else if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         } else {
//                           final productList = snapshot.data!;
//                           return Row(
//                             children: [
//                               Row(
//                                 children: productList.map((product) {
//                                   final productName = product['name'];
//                                   final imageURL = product['imagepath'];
//                                   return Column(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) => Types(
//
//                                                 )),
//                                           );
//                                         },
//                                         child: Container(
//                                           margin: EdgeInsets.only(left: 20),
//                                           width: 150,
//                                           height: 160,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 blurRadius: 5,
//                                                 offset: Offset(1, 1),
//                                                 color: Colors.black26
//                                                     .withOpacity(0.5),
//                                               ),
//                                             ],
//                                             image: DecorationImage(
//                                               image: NetworkImage(
//                                                   imageURL), // Use fetched image URL
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       BigText(
//                                         color: Colors.black,
//                                         text:
//                                             productName, // Use fetched product name
//                                         size: 14,
//                                       ),
//                                     ],
//                                   );
//                                 }).toList(),
//                               ),
//                             ],
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> _fetchProductList(
//       String categoryName) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('Product')
//         .doc(categoryName)
//         .collection('Productone')
//         .get();
//
//     final productList = querySnapshot.docs.map((doc) {
//       final productName = doc.id;
//       final imageURL = doc['imagepath'];
//       return {'name': productName, 'imagepath': imageURL};
//     }).toList();
//
//     return productList;
//   }
// }

class ProductListItem extends StatefulWidget {
  const ProductListItem({Key? key}) : super(key: key);

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  List<String> mainProductDataList = [];

  Future<void> _fetchProduct() async {
    final productQuery =
        await FirebaseFirestore.instance.collection('Product').get();

    setState(() {
      mainProductDataList = productQuery.docs.map((doc) => doc.id).toList();
    });
    print("My Debug: $mainProductDataList");
  }

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 190),
          child: Container(
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
                Icon(Icons.search),
                SizedBox(width: 20),
                Text(
                  'Search Product',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Product',
                  style: TextStyle(color: AppColor.mainColor),
                ),
                Text(
                  'See All',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height:
              MediaQuery.of(context).size.height, // Adjust the height as needed
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: mainProductDataList.length,
            itemBuilder: (context, index) {
              final categoryName = mainProductDataList[index];
              SizedBox(
                height: 20,
              );
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(fontSize: 16),
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchProductList(categoryName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final productList = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Row(
                                  children: productList.map((product) {
                                    // final pName = document.id;
                                    final productName = product['name'];
                                    final imageURL = product['imagepath'];
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Types(
                                                        clickedItemedName:
                                                            productName,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  offset: Offset(1, 1),
                                                  color: Colors.black26
                                                      .withOpacity(0.5),
                                                ),
                                              ],
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    imageURL), // Use fetched image URL
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        BigText(
                                          color: Colors.black,
                                          text:
                                              productName, // Use fetched product name
                                          size: 14,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _fetchProductList(
      String categoryName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Product')
        .doc(categoryName)
        .collection('Productone')
        .get();

    final productList = querySnapshot.docs.map((doc) {
      final productName = doc.id;
      final imageURL = doc['imagepath'];
      return {'name': productName, 'imagepath': imageURL};
    }).toList();

    return productList;
  }
}
