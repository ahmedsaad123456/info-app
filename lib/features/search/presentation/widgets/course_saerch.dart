import 'package:flutter/material.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/presentation/widgets/new_course_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class CourseSaerch extends StatelessWidget {
  const CourseSaerch({super.key, required this.courses});

  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Нашли курсы',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          child: ListView.builder(
            itemCount: courses.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: NewCourseWidget(
                  courseEntity: courses[index],
                  isSearch: true,
                  isHistory: true,
                  courseStateEnum: CourseStateEnum.VIEWED,
                  title: 'Просмотрено',
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
