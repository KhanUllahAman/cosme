import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/admin/admin_categories/sub_sub_categories.dart';
import 'package:cosme/utils/color.dart';
import 'package:cosme/widget/text%20and%20icon/app_icon.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SubCatogeries extends StatefulWidget {
  final String selectproducts;
  const SubCatogeries({Key? key, required this.selectproducts})
      : super(key: key);
  @override
  State<SubCatogeries> createState() => _SubCatogeriesState();
}

class _SubCatogeriesState extends State<SubCatogeries> {
  String subproduct = '';
  List<String> productDataList = [];
  TextEditingController productNameController = TextEditingController();
  TextEditingController imageURLController = TextEditingController();
  File? image;
  final picker = ImagePicker();

  Future<List<QueryDocumentSnapshot>> _fetchProductlist() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Product')
        .doc(widget.selectproducts)
        .collection('Productone')
        .get();
    final productList = querySnapshot.docs.toList();
    print("My Debug: $productList");
    return productList;
  }

  void initState() {
    super.initState();
    _fetchProductlist(); // Fetch regions when the screen initializes
  }

  @override
  void dispose() {
    productNameController.clear();
    super.dispose();
  }

  Future<void> _storeClickedItem(String itemName) async {
    try {
      await FirebaseFirestore.instance
          .collection('ClickedItems')
          .doc(itemName)
          .set({
        'itemName': itemName,
      });
      print('Item $itemName stored successfully');
    } catch (e) {
      print('Error storing item: $e');
    }
  }

  Future<void> addProduct(String productname, File? productImage) async {
    if (productDataList.contains(productname)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Category name already exists'),
              actions: <Widget>[
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text('Ok'),
                ),
              ],
            );
          });
      return;
    }
    try {
      String imageUrl = '';
      if (productImage != null) {
        // Generate a unique name for the image
        String uniqueImageName = Uuid().v4();

        Reference ref = FirebaseStorage.instance
            .ref()
            .child('product_image')
            .child(uniqueImageName);
        UploadTask uploadTask = ref.putFile(productImage!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      await FirebaseFirestore.instance
          .collection('Product')
          .doc(widget.selectproducts)
          .collection('Productone')
          .doc(productname)
          .set({
        'name': productname,
        'imagepath': imageUrl,
      });

      setState(() {
        productDataList.add(productname);
      });

      productNameController.clear();
      imageURLController.clear();
      setState(() {
        image = null;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Product name added successfully'),
              actions: <Widget>[
                TextButton(
                    onPressed: Navigator.of(context).pop, child: Text('Ok')),
              ],
            );
          });
    } catch (e) {
      print('Error adding product: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add product'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Product')
          .doc(widget.selectproducts)
          .collection('Productone')
          .doc(productId)
          .delete();

      setState(() {
        productDataList.remove(productId);
      });
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> _showDeleteConfirmationDialog(String productId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to delete this product?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteProduct(productId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future getGalleryImage() async {
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickFile != null) {
        image = File(pickFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchProductlist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final pDataList = snapshot.data!;
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 10),
                    margin: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        AppIcon(
                          icon: Icons.arrow_back_ios,
                          ontap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Center(
                          child: BigText(
                            text: 'Categories',
                            size: 26,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: productNameController,
                            decoration:
                                InputDecoration(hintText: 'Enter Product name'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColor.textColor, width: 5),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                getGalleryImage();
                              },
                              child: image != null
                                  ? FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Center(
                                      child: Icon(
                                        Icons.image,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: pDataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final document = pDataList[index];
                        final pName = document.id;
                        final imgurl = document.get('imagepath');
                        return Dismissible(
                          key: Key(pName),
                          direction: DismissDirection.endToStart,
                          background: const Card(
                            color: Colors.red,
                            margin: EdgeInsets.only(left: 200),
                            child: Icon(
                              Icons.delete,
                            ),
                          ),
                          onDismissed: (direction) {
                            _showDeleteConfirmationDialog(document.id);
                          },
                          child: ListTile(
                            onTap: () {
                              _storeClickedItem(pName).then((_) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubSubCategories(
                                      clickedItemName: pName,
                                    ),
                                  ),
                                );
                              }).catchError((error) {
                                print('Error storing item: $error');
                              });
                            },
                            title: Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 270,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColor.mainColor,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                            ),
                                            child: ClipOval(
                                              child: imgurl != null
                                                  ? Image.network(
                                                      imgurl,
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                      loadingBuilder:
                                                          (BuildContext context,
                                                              Widget child,
                                                              ImageChunkEvent?
                                                                  loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        } else {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Icon(Icons.error);
                                                      },
                                                    )
                                                  : Center(
                                                      child: Icon(
                                                        Icons.image,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Center(
                                            child: Text(
                                              pName,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 40,
                                      left: 60,
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColor.mainColor,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No product data available'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          String productName = productNameController.text.trim();
          String imageUrl = imageURLController.text.trim();
          if (productName.isNotEmpty) {
            addProduct(productName, image);
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
