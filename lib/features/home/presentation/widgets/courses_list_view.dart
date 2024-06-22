import 'package:flutter/material.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/new_course_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';
import 'package:info_app/features/home/presentation/widgets/filter_course_widget.dart';

class CoursesListView extends StatelessWidget {
  const CoursesListView(
      {super.key,
      required this.courseStateEnum,
      this.isNotPlus,
      required this.courses,
      required this.title,
      required this.subtitle, required this.type});

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
        FilterCourseWidget(type: type, title: title, subtitle: subtitle),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: courses.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: NewCourseWidget(
                    courseEntity: courses[index],
                    courseStateEnum: courseStateEnum,
                    isNotPlus: isNotPlus,
                    isBookmark: false,
                    isHistory: false,
                  ));
            },
          ),
        ),
      ],
    );
  }
}
