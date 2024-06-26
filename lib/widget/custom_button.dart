import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.height,
    this.width,
    required this.color,
    required this.textColor,
    this.gradient,
    this.boxBorder,
    this.padding,
  });
  final String text;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final Color textColor;
  final Gradient? gradient;
  final BoxBorder? boxBorder;
  final EdgeInsets? padding;
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          border: boxBorder,
          borderRadius: BorderRadius.circular(64),
        ),
        child: Center(
            child: Padding(
                padding: padding ?? EdgeInsets.zero,
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: 'SuisseIntl',
                    fontWeight: FontWeight.w500,
                  ),
                ))),
      ),
    );
  }
}
