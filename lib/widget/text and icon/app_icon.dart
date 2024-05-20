import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconColor;
  final double iconSize;
  final double size;
  final void Function()? ontap;

  const AppIcon({
    Key? key,
    required this.icon,
    this.background = const Color(0XFFfcf4e4),
    this.iconSize = 16,
    this.iconColor = const Color(0XFF756D54),
    this.size = 40,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 2), color: background),
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          )),
    );
  }
}
