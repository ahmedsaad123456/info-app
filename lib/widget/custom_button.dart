import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.text, this.onTap,  required this.height, this.width, required this.color, required this.textColor, this.gradient, this.boxBorder, this.padding,});
  final String text;
  final double height;
  final double? width;
  final void Function()? onTap;
  final Color textColor;
  final Gradient? gradient;
  final BoxBorder? boxBorder;
  final double? padding;
  // final Color borderColor;
  // final Gradient? gradient;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
            color: color,
            border: boxBorder,
            borderRadius: BorderRadius.circular(64),

        ),
        child: Center(child: Padding(padding: EdgeInsets.symmetric(horizontal: padding ?? 0), child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),))),
      ),
    );
  }
}
