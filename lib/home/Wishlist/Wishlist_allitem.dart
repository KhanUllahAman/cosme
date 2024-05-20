import 'package:cosme/mycart/add_to_cart.dart';
import 'package:cosme/utils/color.dart';
import 'package:cosme/widget/text%20and%20icon/app_icon.dart';
import 'package:cosme/widget/button/text_button.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:cosme/widget/text%20and%20icon/small_text.dart';
import 'package:flutter/material.dart';

class WishListItem extends StatefulWidget {
  const WishListItem({Key? key}) : super(key: key);

  @override
  State<WishListItem> createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(left: 20, top: 80, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(
                icon: Icons.arrow_back_ios,
                ontap: () {
                  Navigator.of(context).pop();
                },
              ),
              Center(child: BigText(text: "Wishlist")),
              AppIcon(
                icon: Icons.shopping_bag_outlined,
                ontap: () {
                  Navigator.of(context).pop();
                },
              ),
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        BigText(
                          text: '\$ 13.50',
                          color: AppColor.mainColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Button(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddToCart()));
                          },
                          text: 'Add to cart',
                        ),
                      ],
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        BigText(
                          text: '\$ 13.50',
                          color: AppColor.mainColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Button(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddToCart()));
                          },
                          text: 'Add to cart',
                        ),
                      ],
                    ),
                  ],
                ),
              ])),
        ],
      ),
    ));
  }
}
