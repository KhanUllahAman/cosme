import 'package:cosme/mycart/add_to_cart.dart';
import 'package:cosme/utils/color.dart';
import 'package:cosme/widget/text%20and%20icon/small_text.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  const Button(
      {Key? key, required Null Function() onPressed, required this.text})
      : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.mainColor, Colors.deepOrange],
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange,
              offset: Offset(1, 1),
              blurRadius: 10,
              spreadRadius: 1,
              blurStyle: BlurStyle.inner,
            )
          ]),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (content) => AddToCart()));
        },
        child: Center(
          child: SmallText(
            size: 16,
            text: '',
          ),
        ),
      ),
    );
  }
}
