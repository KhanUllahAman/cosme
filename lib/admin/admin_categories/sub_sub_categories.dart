import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/utils/color.dart';

import 'package:flutter/material.dart';

class SubSubCategories extends StatefulWidget {
  final String clickedItemName;
  const SubSubCategories({required this.clickedItemName, Key? key})
      : super(key: key);

  @override
  State<SubSubCategories> createState() => _SubSubCategoriesState();
}

class _SubSubCategoriesState extends State<SubSubCategories> {
  var myList = <String>[];

  late CollectionReference productCollection;

  Future<List<QueryDocumentSnapshot>> _fetchSubCategories() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('ClickedItems')
        .doc(widget.clickedItemName)
        .collection('Items')
        .get();

    final productList = querySnapshot.docs.toList();
    print("My debug: $productList");

    return productList;
  }

  @override
  void initState() {
    super.initState();
    _fetchSubCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchSubCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final pDataList = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: pDataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final document = pDataList[index];
                        final pName = document.id;
                        final name = document.get('name');
                        final description = document.get('description');
                        final price = document.get('price');
                        // final imgrurl=document.get('imagepath');

                        return Dismissible(
                            key: Key(pName),
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
                              setState(() {
                                // items.removeAt(index);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 400,
                                child: ListTile(
                                  onTap: () {},
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: 250,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColor.mainColor,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image(
                                                  width: 150,
                                                  height: 150,
                                                  image: AssetImage(
                                                      'assets/images/blushon.png')),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Name:$name",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Description:",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      description,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Price:RS $price",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          // Handle edit action here
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
                  )
                ],
              );
            } else {
              return Center(child: Text('No route data available'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _addItemToFirebase();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
