import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatelessWidget {
  const PinputWidget({super.key, this.onChanged, required this.controller});
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      
      onChanged: onChanged,
      onCompleted: (value) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value!.length != 4) {
          return 'Invalid code';
        }
        return null;
      },
      controller: controller,
      preFilledWidget: SvgPicture.asset('assets/icons/zero.svg'),
      length: 4,
      defaultPinTheme: PinTheme(
        width: 64,
        height: 64,
        textStyle: TextStyle(
          height: 1,
          
            color: Colors.white, fontSize: 48, fontWeight: FontWeight.w500),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          border: Border.all(width: 4, color: Colors.white.withOpacity(0.18)),
          borderRadius: BorderRadius.circular(8),
        
        ),
      
      ),
      focusedPinTheme: PinTheme(
        

        width: 64,
        height: 64,
        textStyle: TextStyle(
          height: 1,
            color: Colors.white, fontSize: 48, fontWeight: FontWeight.w500),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          border: Border.all(width: 4, color: Colors.white.withOpacity(0.18)),
                    borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
