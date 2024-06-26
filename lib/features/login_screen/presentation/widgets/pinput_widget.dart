import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/core/customs/base_otp_field.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatelessWidget {
  const PinputWidget({super.key, this.onChanged});
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return OTPTextField(
      length: 4,
      contentWidth: MediaQuery.of(context).size.width,
      fieldWidth: 64,
      isDense: true,
      // controller: controller,

      contentPadding: const EdgeInsets.only(
        right: 8,
        left: 8,
        top: 10,
        bottom: 7,
      ),
      spaceBetween: 8,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
        color: Theme.of(context).cardColor,
        fontFeatures: [
          const FontFeature.slashedZero(),
        ],
      ),
      hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
          color: Colors.white.withOpacity(0.18000000715255737),
          fontSize: 48,
          fontFamily: 'SuisseIntl',
          fontWeight: FontWeight.w500,
          height: 0.02,
          letterSpacing: -1.44,
          fontFeatures: [
            const FontFeature.slashedZero(),
          ]),
      textFieldAlignment: MainAxisAlignment.center,
      fieldStyle: FieldStyle.box,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.transparent,
        borderColor: const Color(0xfff8206e),
        disabledBorderColor: Theme.of(context).dividerColor,
        enabledBorderColor: Theme.of(context).dividerColor,
        focusBorderColor: const Color(0xfff8206e),
        errorBorderColor: Colors.red,
      ),
      borderRadius: 8,
      inputFormatter: [getMaskCode()],
      onChanged: onChanged,
    );

    // Pinput(
    //   onChanged: onChanged,
    //   onCompleted: (value) {
    //     FocusScope.of(context).unfocus();
    //   },
    //   validator: (value) {
    //     if (value!.length != 4) {
    //       return 'Invalid code';
    //     }
    //     return null;
    //   },
    //   controller: controller,
    //   preFilledWidget: SvgPicture.asset('assets/icons/zero.svg'),
    //   length: 4,
    //   defaultPinTheme: PinTheme(
    //     width: 64,
    //     height: 64,
    //     textStyle: const TextStyle(
    //         height: 1,
    //         color: Colors.white,
    //         fontSize: 48,
    //         fontWeight: FontWeight.w500),
    //     decoration: BoxDecoration(
    //       color: Colors.white.withOpacity(0.08),
    //       border: Border.all(
    //         width: 3,
    //         color: Colors.white.withOpacity(0.18),
    //       ),
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //   ),
    //   focusedPinTheme: PinTheme(
    //     width: 64,
    //     height: 64,
    //     textStyle: const TextStyle(
    //         height: 1,
    //         color: Colors.white,
    //         fontSize: 48,
    //         fontWeight: FontWeight.w500),
    //     decoration: BoxDecoration(
    //       color: Colors.white.withOpacity(0.08),
    //       border: Border.all(width: 4, color: Colors.white.withOpacity(0.18)),
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //   ),
    // );
  }
}
