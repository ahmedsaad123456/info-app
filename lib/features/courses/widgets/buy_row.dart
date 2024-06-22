import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuyRow extends StatelessWidget {
  const BuyRow({super.key, this.isNotPlus});

  final bool? isNotPlus;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/lock.svg', color:Color(0xFFF8206E) ,),
        const SizedBox(
          width: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 27,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
