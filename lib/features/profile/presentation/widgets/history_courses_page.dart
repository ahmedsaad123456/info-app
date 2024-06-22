import 'package:flutter/material.dart';
import 'package:info_app/features/courses/widgets/course_series_item.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/new_course_widget.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class HistoryCoursesPage extends StatelessWidget {
  const HistoryCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      'История просмотра',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'История просмотра',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Здесь ты найдёшь курсы и видео, которые уже видел. Можешь пересмотреть их',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.64)),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 15,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: AspectRatio(
                              aspectRatio: 180 / 100,
                              child: CourseSeriesItem(
                                  containerTitle: 'Просмотрено',
                                  title: 'Новое видео',
                                  time: '20:18 / 20:18',
                                  courseStateEnum: CourseStateEnum.VIEWED)));
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ListView.builder(
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: NewCourseWidget(
                          courseEntity: CourseEntity(),
                          isHistory: false,
                          courseStateEnum: CourseStateEnum.VIEWED,
                          isBookmark: false,
                          title: 'Просмотрено',
                        ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
