import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/admin/admin_categories/sub%20_catogries.dart';
import 'package:cosme/utils/color.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String selecteditem = '';
  var myList = <String>[];
  List<String> MainProductDataList = [];
  TextEditingController regionNameController = TextEditingController();
  TextEditingController editNameController = TextEditingController();

  Future<void> _fetchProduct() async {
    final productquery =
        await FirebaseFirestore.instance.collection('Product').get();

    setState(() {
      MainProductDataList = productquery.docs.map((doc) => doc.id).toList();
    });
    print("My Debug: $MainProductDataList");
  }

  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Product')
          .doc(productId)
          .delete();

      setState(() {
        MainProductDataList.remove(productId);
      });
    } catch (e) {
      print('Error deleting product');
    }
  }

  Future<void> addProduct(String itemName) async {
    if (MainProductDataList.contains(itemName)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Name already exists'),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return;
    }

    final RegExp alphabetsPattern = RegExp(r'^[A-Za-z\s]+$');
    if (!alphabetsPattern.hasMatch(itemName)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Categories name should consist of alphabets. Numbers and special characters are not allowed'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Product').doc(itemName).set({
        'name': itemName,
      });
      setState(() {
        MainProductDataList.add(itemName);
      });
      regionNameController.clear();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Product added successfully!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error adding region: $e');
    }
  }

  Future<void> editProduct(String oldProductId, String newProductId) async {
    if (MainProductDataList.contains(newProductId)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Product name already exists'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      final document = FirebaseFirestore.instance.collection('Product').doc(oldProductId);
      final snapshot = await document.get();

      if (snapshot.exists) {
        await document.delete();
        await FirebaseFirestore.instance.collection('Product').doc(newProductId).set({
          'name': newProductId,
        });

        setState(() {
          int index = MainProductDataList.indexOf(oldProductId);
          MainProductDataList[index] = newProductId;
        });

        Navigator.of(context, rootNavigator: true).pop(); // Close the edit dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Product updated successfully!'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(); // Close the success dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error editing product: $e');
    }
  }

  void showEditDialog(String currentProduct) {
    editNameController.text = currentProduct;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Selected Product'),
          content: TextField(
            controller: editNameController,
            decoration: InputDecoration(hintText: 'Enter new product name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                String newProductName = editNameController.text.trim();
                if (newProductName.isNotEmpty && newProductName != currentProduct) {
                  editProduct(currentProduct, newProductName);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(children: [
              BigText(text: 'Categories'),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: regionNameController,
                decoration: InputDecoration(
                  hintText: 'Enter Product name',
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: MainProductDataList.length,
              itemBuilder: (BuildContext context, int index) {
                final itemName = MainProductDataList[index];
                return Dismissible(
                  key: Key(itemName),
                  direction: DismissDirection.endToStart,
                  background: const Card(
                    color: Colors.red,
                    margin: EdgeInsets.only(
                      left: 200,
                    ),
                    child: Icon(
                      Icons.delete,
                    ),
                  ),
                  onDismissed: (direction) {
                    String productId = MainProductDataList[index];
                    print("Deleting product Id: $productId");
                    deleteProduct(productId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCatogeries(
                                selectproducts: itemName,
                              ),
                            ),
                          );
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.mainColor,
                              ),
                              child: Center(
                                child: Text(
                                  MainProductDataList[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showEditDialog(itemName);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          String itemName = regionNameController.text.trim();
          if (itemName.isNotEmpty) {
            addProduct(itemName);
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
