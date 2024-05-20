import 'package:cosme/utils/color.dart';
import 'package:cosme/widget/text%20and%20icon/app_icon.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:cosme/widget/text%20and%20icon/small_text.dart';
import 'package:flutter/material.dart';

class ProductItemDescription extends StatelessWidget {
  const ProductItemDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 30),
                width: 150,
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      color: Colors.black,
                      text: 'Cleaser 1',
                      size: 16,
                    ),
                    SmallText(text: '\$12.50', color: AppColor.mainColor),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.only(bottom: 30),
              child: AppIcon(icon: Icons.favorite),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                width: 150,
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      color: Colors.black,
                      text: 'Moisturizer',
                      size: 16,
                    ),
                    SmallText(text: '\$12.50', color: AppColor.mainColor),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.only(bottom: 30),
              child: AppIcon(
                  icon: Icons.favorite,
                  // iconColor: AppColor.mainColor,
                  iconColor: Colors.deepOrange),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
