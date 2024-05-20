import 'package:cosme/utils/color.dart';
import 'package:cosme/widget/text%20and%20icon/app_icon.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:cosme/widget/text%20and%20icon/small_text.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(
        left: 20,
        top: 80,
      ),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(
                icon: Icons.arrow_back_ios,
                ontap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 100,
              ),
              Center(child: BigText(text: "My Cart")),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              margin: EdgeInsets.only(right: 10),
              width: 500,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(1, 1),
                      color: Colors.deepOrange.withOpacity(0.5)),
                ],
              ),
              child: Row(children: [
                Image(image: AssetImage('assets/images/lipstick.png')),
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Cherry Makes Cheerfull',
                      size: 16,
                    ),
                    SmallText(
                      text: 'Velvet with a mouses texture ',
                    ),
                    BigText(
                      text: '\$ 13.50',
                      color: AppColor.mainColor,
                    ),
                  ],
                ),
              ])),
          SizedBox(
            height: 30,
          ),
          Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              margin: EdgeInsets.only(right: 10),
              width: 500,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(1, 1),
                      color: Colors.deepOrange.withOpacity(0.5)),
                ],
              ),
              child: Row(children: [
                Image(image: AssetImage('assets/images/hair.png')),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Cherry Makes Cheerfull',
                      size: 16,
                    ),
                    SmallText(
                      text: 'Velvet with a mouses texture ',
                    ),
                    BigText(
                      text: '\$ 13.50',
                      color: AppColor.mainColor,
                    ),
                  ],
                ),
              ])),
        ],
      ),
    ));
  }
}
