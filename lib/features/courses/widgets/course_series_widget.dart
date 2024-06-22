import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info_app/features/courses/widgets/course_series_item.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/title_widget.dart';

class CourseSeriesWidget extends StatelessWidget {
  const CourseSeriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TitleWidget(
            title: 'Серии курса',
            subtitle:
                'Тут представлены видеоролики, которые \nвxoдят в этот курс'),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: CourseSeriesItem(
                title: 'Серия 1 — Тизер',
                time: '20:18',
                courseStateEnum: CourseStateEnum.VIEWED,
                containerTitle: 'Просмотрено',
              ),
            );
          },
        )
      ],
    );
  }
}
