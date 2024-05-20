import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String clickedItemName;
  const AddProduct({Key? key, required this.clickedItemName}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image;
  final picker = ImagePicker();
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  Future<void> _addProductToFirestore() async {
    // Check if any of the text fields are empty
    if (productNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty) {
      print('Please fill in all fields');
      // Optionally, you can display a message to the user
      return; // Exit the method early, without adding the product
    }
    try {
      await FirebaseFirestore.instance
          .collection("ClickedItems")
          .doc(widget.clickedItemName)
          .collection('Items')
          .add({
        'name': productNameController.text,
        'description': descriptionController.text,
        'price': priceController.text,
        // Add more fields if needed
      });
      productNameController.clear();
      descriptionController.clear();
      priceController.clear();
      print('Product added successfully');
      // Optionally, you can navigate back to the previous screen or perform any other actions
    } catch (e) {
      print('Error adding product: $e');
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 150),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.pinkAccent, width: 10),
          ),
          child: Center(
            child: Icon(
              Icons.image,
              color: Colors.black26,
              size: 70,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 35, right: 35),
              child: TextFormField(
                controller: productNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: ' product name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 35, right: 35),
              child: TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: ' Description',
                ),
                maxLines: 6,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 35, right: 35),
              child: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'price'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _addProductToFirestore();
              },
              child: Container(
                height: 50,
                width: 200,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 35, right: 35),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Color(0XFFFB415B), Color(0XFFEE5623)],
                    )),
                child: Center(
                  child: BigText(
                    text: 'Add product',
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import statement
//
// class AddProduct extends StatefulWidget {
//   final String clickedItemName;
//   const AddProduct({Key? key, required this.clickedItemName}) : super(key: key);
//
//   @override
//   State<AddProduct> createState() => _AddProductState();
// }
//
// class _AddProductState extends State<AddProduct> {
//   File? image;
//   final picker = ImagePicker();
//   final productNameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final priceController = TextEditingController();
//
//   Future<void> _addProductToFirestore() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("ClickedItems")
//           .doc(widget.clickedItemName)
//           .collection('Items')
//           .add({
//         'name': productNameController.text,
//         'description': descriptionController.text,
//         'price': priceController.text,
//         // Add more fields if needed
//       });
//       print('Product added successfully');
//       // Optionally, you can navigate back to the previous screen or perform any other actions
//     } catch (e) {
//       print('Error adding product: $e');
//       // Handle error if needed
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Your existing UI code...
//             TextFormField(
//               controller: productNameController,
//               keyboardType: TextInputType.text,
//               decoration: const InputDecoration(
//                 hintText: 'Product name',
//               ),
//             ),
//             TextFormField(
//               controller: descriptionController,
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               decoration: const InputDecoration(
//                 hintText: 'Description',
//               ),
//             ),
//             TextFormField(
//               controller: priceController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 hintText: 'Price',
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _addProductToFirestore();
//               },
//               child: const Text('Add product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
