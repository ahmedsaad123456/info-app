import 'package:flutter/material.dart';
import 'package:info_app/features/home/presentation/widgets/course_owner_image.dart';

class CourseOwnerWidget extends StatelessWidget {
  const CourseOwnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Наши клиенты',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          SizedBox(
            height: 16,
          ),
          CourseOwnerImage(),
          SizedBox(
            height: 12,
          ),
          CourseOwnerImage(),
        ],
      ),
    );
  }
}
