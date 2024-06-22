import 'package:flutter/material.dart';

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
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(
                0.64,
              ),
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
