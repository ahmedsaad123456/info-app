import 'package:flutter/material.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/presentation/widgets/new_course_widget.dart';
import 'package:info_app/features/courses/presentation/widgets/title_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';

class AllCoursesWidget extends StatelessWidget {
  const AllCoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCouit = HomeCubit.get(context);
    int lenCourse = homeCouit.courseModel?.length ?? 0;
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
        Center(
          child: SizedBox(
            width: 350,
            child: ListView.builder(
              itemCount: lenCourse > 4 ? 4 : lenCourse,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: NewCourseWidget(
                    courseEntity:
                        homeCouit.courseModel?[index] ?? CourseEntity(),
                    courseStateEnum: CourseStateEnum.PURCHASED,
                    isHistory: false,
                    title: 'Просмотрено',
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
