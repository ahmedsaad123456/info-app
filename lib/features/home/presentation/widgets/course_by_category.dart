import 'package:flutter/material.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/new_course_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class CourseByCategory extends StatelessWidget {
  const CourseByCategory(
      {super.key,
      required this.title,
      required this.courseStateEnum,
      this.titleContainer,
      required this.isBookmark,
      this.isNotPlus});

  final String title;
  final String? titleContainer;

  final CourseStateEnum courseStateEnum;
  final bool isBookmark;
  final bool? isNotPlus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 15,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: NewCourseWidget(
                  courseEntity: CourseEntity(),
                  isHistory: false,
                  courseStateEnum: courseStateEnum,
                  isBookmark: isBookmark,
                  title: titleContainer,
                  isNotPlus: isNotPlus,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
