import 'package:cosme/home/product_home_list/product_list_items.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:cosme/widget/text%20and%20icon/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils/color.dart';

class MainProduct extends StatefulWidget {
  const MainProduct({Key? key}) : super(key: key);

  @override
  State<MainProduct> createState() => _MainProductState();
}

class _MainProductState extends State<MainProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 210,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: AppColor.mainColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: 'Hi Javeria',
                          color: Colors.white,
                        ),
                        SmallText(
                          text: 'It\'s time to add product to cart',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
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
              ],
            ),
            ProductListItem(),
          ],
        ),
      ),
    );
  }
}
