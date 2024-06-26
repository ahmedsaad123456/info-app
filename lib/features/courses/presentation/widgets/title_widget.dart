import 'package:flutter/material.dart';
import 'package:info_app/core/constants.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        4.ph,
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6399999856948853),
            fontSize: 16,
            fontFamily: 'SuisseIntl',
            fontWeight: FontWeight.w400,
            height: 1.2,
            letterSpacing: -0.48,
          ),
        ),
      ],
    );
  }
}
