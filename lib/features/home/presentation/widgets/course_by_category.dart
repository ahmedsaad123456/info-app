import 'package:flutter/material.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/presentation/widgets/new_course_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class CourseByCategory extends StatelessWidget {
  const CourseByCategory(
      {super.key,
      required this.title,
      required this.courses,
      required this.courseStateEnum,
      this.titleContainer,
      required this.isBookmark,
      this.isNotPlus});

  final String title;
  final List<CourseEntity> courses;
  final String? titleContainer;
  final CourseStateEnum courseStateEnum;
  final bool isBookmark;
  final bool? isNotPlus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: courses.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: NewCourseWidget(
                  courseEntity: courses[index],
                  isHistory: false,
                  courseStateEnum: courseStateEnum,
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
