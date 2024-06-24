import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/features/courses/presentation/cubit/course_cubit.dart';
import 'package:info_app/features/courses/presentation/widgets/all_courses_widget.dart';
import 'package:info_app/features/courses/presentation/widgets/course_button.dart';
import 'package:info_app/features/courses/presentation/widgets/course_series_widget.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/presentation/widgets/new_course_widget.dart';
import 'package:info_app/features/courses/presentation/widgets/title_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key, required this.courseStateEnum});

  final CourseStateEnum courseStateEnum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            if (state is CourseLoaded) {
              var course = state.courseResponseModel;
              print("vvvvv${course.courseModel?.materials}");
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          const Spacer(),
                          Text(
                            course.courseModel?.name ?? "",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: NewCourseWidget(
                          courseEntity: course.courseModel ?? CourseEntity(),
                          isHistory: true,
                          courseStateEnum: courseStateEnum,
                          isNotPlus: false,
                          title: 'Просмотрено',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CourseButton(courseStateEnum: courseStateEnum),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          'Продолжить c «День первый»',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(
                                0.64,
                              ),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: TitleWidget(
                          title: 'Описание курса',
                          subtitle: course.courseModel?.description ?? "",
                        ),
                      ),
                      CourseSeriesWidget(
                        materialEntity: course.courseModel?.materials ?? [],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const AllCoursesWidget(),
                    ],
                  ),
                ),
              );
            } else if (state is CourseError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
