import 'package:flutter/material.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/new_course_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class CourseSaerch extends StatelessWidget {
  const CourseSaerch({super.key});

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
          width: 350,
          child: ListView.builder(
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: NewCourseWidget(
                  courseEntity: CourseEntity(),
                  isHistory: false,
                  courseStateEnum: CourseStateEnum.VIEWED,
                  isBookmark: false,
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
