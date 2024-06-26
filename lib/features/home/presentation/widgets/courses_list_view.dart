import 'package:flutter/material.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/presentation/widgets/new_course_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';
import 'package:info_app/features/home/presentation/widgets/filter_course_widget.dart';

class CoursesListView extends StatelessWidget {
  const CoursesListView(
      {super.key,
      required this.courseStateEnum,
      this.isNotPlus,
      required this.courses,
      required this.title,
      required this.subtitle,
      required this.type});

  final String title, subtitle;
  final CourseStateEnum courseStateEnum;
  final bool? isNotPlus;
  final List<CourseEntity> courses;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              FilterCourseWidget(type: type, title: title, subtitle: subtitle),
        ),
        16.ph,
        SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: courses.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              var course = courses[index];
              return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: NewCourseWidget(
                    courseEntity: course,
                    courseStateEnum: courseStateEnum,
                    isNotPlus: isNotPlus,
                    isHistory: false,
                  ));
            },
          ),
        ),
      ],
    );
  }
}
