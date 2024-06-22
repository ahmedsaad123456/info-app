import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.focusNode,
      required this.controller,
      this.obscureText,
      this.validator,
      this.labelText,
      this.textInputAction,
      this.keyboardType,
      this.inputFormatters,
      required this.textHint,
      this.padding,
      this.iconData,
      this.width});

  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String? labelText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String textHint;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final Widget? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.12),
      ),
      child: Row(
        children: [
          if (iconData != null)
            Padding(padding: const EdgeInsets.all(8.0), child: iconData),
          Expanded(
            child: TextFormField(
              cursorColor: Colors.white,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              onChanged: onChanged,
              focusNode: focusNode,
              controller: controller,
              validator: validator,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 20,
                  fontFeatures: <FontFeature>[FontFeature.slashedZero()]),
              decoration: InputDecoration(
                counterText: '',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.12),
                  fontFeatures: const <FontFeature>[FontFeature.slashedZero()],
                ),
                contentPadding: padding,
                hintText: textHint,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40)),
                labelText: labelText,
              ),
              textInputAction: textInputAction,
            ),
          ),
        ],
      ),
    );
  }
}
