import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/home/product_home_list/product_list_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class ProductDetail extends StatefulWidget {
//   const ProductDetail({Key? key}) : super(key: key);
//
//   @override
//   State<ProductDetail> createState() => _ProductDetailState();
// }
//
// class _ProductDetailState extends State<ProductDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white70,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             toolbarHeight: 70,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 220),
//                   child: AppIcon(
//                     icon: Icons.favorite,
//                     iconColor: Colors.deepOrange,
//                     ontap: () {
//                       print("Tapped on the clear icon");
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                             builder: (context) => ProductListItem()),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(20),
//               child: Container(
//                 child: Center(
//                   child: BigText(
//                     size: 18,
//                     text: "Everything is here for your beauty needs",
//                   ),
//                 ),
//                 width: double.maxFinite,
//                 padding: EdgeInsets.only(top: 5, bottom: 10),
//                 decoration: BoxDecoration(
//                     color: Colors.white70,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     )),
//               ),
//             ),
//             backgroundColor: AppColor.mainColor,
//             expandedHeight: 500,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 padding: EdgeInsets.only(top: 100),
//                 child: Image.asset(
//                   "assets/images/mosturizer.png",
//                   width: double.maxFinite,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Column(children: [
//               Container(
//                 child: ExtendedText(
//                     text:
//                         "Indulge in the ritual of skincare, where each product whispers secrets of renewal to your skin. From cleansing to moisturizing, every step is a graceful move towards radiance and confidence. With the precision of an artist, blend foundation seamlessly for a flawless canvas. Adorn lips with hues ranging from soft pink to bold crimson, expressing your unique beauty. Step into the world, your beauty becomes a proclamation of your inner light shining brightly."),
//                 margin: EdgeInsets.only(
//                   left: 20,
//                 ),
//               ),
//             ]),
//           )
//         ],
//       ),
//
//       // child: Text,
//     );
//   }
// }

class ProductDetail extends StatefulWidget {
  final String productId;
  final String clickedItemedName;
  const ProductDetail(
      {Key? key, required this.clickedItemedName, required this.productId})
      : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Future<DocumentSnapshot> _fetchProductDescription(String productId) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('ClickedItems')
        .doc(widget
            .clickedItemedName) // Assuming you have clickedItemedName property
        .collection('Items')
        .doc(productId) // Fetch document for the specific product ID
        .get();

    return documentSnapshot;
  }

  Future<String> getDynamicProductId() async {
    try {
      // Fetch the document containing the product ID
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('ClickedItems')
          .doc(widget.clickedItemedName)
          .collection('Items')
          .doc(widget.productId)
          .get();

      // Extract product ID from the document snapshot
      String productId =
          productSnapshot.id; // Or use productSnapshot.data()['productId']

      return productId;
    } catch (e) {
      print('Error fetching product ID: $e');
      // Handle error
      return ''; // Return an empty string or any default value
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white70,
  //     body: FutureBuilder<DocumentSnapshot>(
  //       future: _fetchProductDescription(
  //           widget.productId), // Pass the product ID here
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (!snapshot.hasData || snapshot.data == null) {
  //           return Center(child: Text('Product not found'));
  //         } else {
  //           final productData = snapshot.data!;
  //
  //           return CustomScrollView(slivers: [
  //             SliverAppBar(
  //               toolbarHeight: 70,
  //               title: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 220),
  //                     child: IconButton(
  //                       icon: Icon(Icons.favorite),
  //                       color: Colors.deepOrange,
  //                       onPressed: () {
  //                         print("Tapped on the clear icon");
  //                         Navigator.of(context).pushReplacement(
  //                           MaterialPageRoute(
  //                             builder: (context) => ProductListItem(),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               bottom: PreferredSize(
  //                 preferredSize: Size.fromHeight(20),
  //                 child: Container(
  //                   child: Center(
  //                     child: Text(
  //                       "Everything is here for your beauty needs",
  //                       style: TextStyle(fontSize: 18),
  //                     ),
  //                   ),
  //                   width: double.maxFinite,
  //                   padding: EdgeInsets.only(top: 5, bottom: 10),
  //                   decoration: BoxDecoration(
  //                     color: Colors.white70,
  //                     borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(20),
  //                       topRight: Radius.circular(20),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               expandedHeight: 500,
  //               pinned: true,
  //               flexibleSpace: FlexibleSpaceBar(
  //                 background: Container(
  //                   padding: EdgeInsets.only(top: 100),
  //                   child: Image.asset(
  //                     "assets/images/mosturizer.png",
  //                     width: double.maxFinite,
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SliverList(delegate: SliverChildBuilderDelegate((context, index) {
  //               return Column(
  //                 children: [
  //                   Container(
  //                     child: Text(
  //                       productData['description'],
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                     margin: EdgeInsets.only(left: 20),
  //                   ),
  //                 ],
  //               );
  //             })),
  //           ]);
  //         }
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: FutureBuilder<DocumentSnapshot>(
        future: _fetchProductDescription(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Product not found'));
          } else {
            final productData = snapshot.data!;
            print('Product data: $productData');

            if (!productData.exists) {
              return Center(child: Text('Product document does not exist'));
            }

            // Check if productData is not null and contains the 'description' field
            final dynamicData = productData.data();
            if (dynamicData is Map<String, dynamic> &&
                dynamicData.containsKey('description')) {
              final description = productData['description'];
              print('Description: $description');

              return CustomScrollView(
                slivers: [
                  // Your SliverAppBar and SliverList widgets
                ],
              );
            } else {
              return Center(child: Text('Description field not found'));
            }
          }
        },
      ),
    );
  }
}
