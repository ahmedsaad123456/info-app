import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/core/constants.dart';

class BuyRow extends StatelessWidget {
  const BuyRow({super.key, this.isNotPlus});

  final bool? isNotPlus;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.lock_outline, color: Color(0xFFF8206E)),
        8.pw,
        Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 27,
          width: 76,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color.fromRGBO(255, 136, 136, 1),
                Color.fromRGBO(255, 55, 151, 1),
              ],
            ),
            color: const Color.fromRGBO(248, 32, 110, 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              isNotPlus == null ? 'Нейро+' : 'Нейро',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Suisse Intl',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.48,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
