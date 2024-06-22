import 'package:flutter/material.dart';
import 'package:info_app/features/courses/widgets/all_courses_widget.dart';
import 'package:info_app/features/courses/widgets/course_button.dart';
import 'package:info_app/features/courses/widgets/course_series_widget.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/new_course_widget.dart';
import 'package:info_app/features/courses/widgets/title_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key, required this.courseStateEnum});

  final CourseStateEnum courseStateEnum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      'Карта желаний',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                NewCourseWidget(
                  courseEntity: CourseEntity(),
                  courseStateEnum: courseStateEnum,
                  isBookmark: false,
                  isHistory: false,
                  title: 'Просмотрено',
                ),
                const SizedBox(
                  height: 20,
                ),
                CourseButton(courseStateEnum: courseStateEnum),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Продолжить c «День первый»',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(
                        0.64,
                      ),
                      fontWeight: FontWeight.w400),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TitleWidget(
                      title: 'Описание курса',
                      subtitle:
                          'Посмотрев марафон карта желаний,\nты поймёшь связь между твоими желаниями и слоями подсознания',
                    ),
                  ),
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: CourseSeriesWidget()),
                const SizedBox(
                  height: 16,
                ),
                const Align(
                    alignment: Alignment.centerLeft, child: AllCoursesWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
