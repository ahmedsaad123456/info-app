import 'package:flutter/material.dart';

class CourseOwnerImage extends StatelessWidget {
  const CourseOwnerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                      width: 1, color: Colors.white.withOpacity(0.08)))),
          height: 250,
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: Image.asset(
            'assets/icons/home2.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Филипп Киркоров',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Российский эстрадный певец',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(
                      0.64,
                    ),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
