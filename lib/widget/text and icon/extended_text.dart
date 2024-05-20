import 'package:cosme/widget/text%20and%20icon/small_text.dart';
import 'package:flutter/material.dart';

import '../../utils/color.dart';

class ExtendedText extends StatefulWidget {
  final String text;
  const ExtendedText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExtendedText> createState() => _ExtendedTextState();
}

class _ExtendedTextState extends State<ExtendedText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = 844 / 5.63;

  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(
                text: firstHalf,
                height: 1.8,
                color: AppColor.textColor,
                size: 16,
              )
            : Column(
                children: [
                  SmallText(
                      color: Colors.black,
                      size: 16,
                      text: hiddenText
                          ? (firstHalf + "...")
                          : (firstHalf + secondHalf)),
                  InkWell(
                      onTap: () {
                        setState(() {
                          hiddenText = !hiddenText;
                        });
                      },
                      child: Row(
                        children: [
                          SmallText(
                            text: "show more",
                            color: AppColor.mainColor,
                          ),
                          Icon(
                            hiddenText
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: AppColor.mainColor,
                          ),
                        ],
                      ))
                ],
              ));
  }
}
