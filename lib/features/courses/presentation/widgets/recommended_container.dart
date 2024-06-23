import 'package:flutter/material.dart';

class RecommendedContainer extends StatelessWidget {
  const RecommendedContainer({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 27,
      decoration: BoxDecoration(
        gradient: title == 'Нейро' ? const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color.fromRGBO(255, 136, 136, 1),
                Color.fromRGBO(255, 55, 151, 1),
              ],
            ): null,
        color: const Color(0xFFF8206E),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
    );
  }
}
