import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info_app/features/courses/widgets/course_series_item.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/title_widget.dart';
import 'package:info_app/features/home/domain/entities/material_entity.dart';

class CourseSeriesWidget extends StatelessWidget {
  const CourseSeriesWidget({super.key, required this.materialEntity});

  final List< MaterialEntity> materialEntity;

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
          itemCount: materialEntity.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: CourseSeriesItem(
                materialEntity: materialEntity[index],
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
