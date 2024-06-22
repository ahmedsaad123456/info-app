import 'package:flutter/material.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/new_course_widget.dart';
import 'package:info_app/features/courses/widgets/title_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class AllCoursesWidget extends StatelessWidget {
  const AllCoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(
            title: 'Смотреть также',
            subtitle:
                'Здесь тынайдёшь курсы, которые могут тебе \nбыть интересны'),
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
                  courseStateEnum: CourseStateEnum.VIEWED,
                  isBookmark: false,
                  isHistory: false,
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
