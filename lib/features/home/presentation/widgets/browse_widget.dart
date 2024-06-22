import 'package:flutter/material.dart';
import 'package:info_app/features/courses/widgets/course_series_item.dart';
import 'package:info_app/features/courses/course_state_enum.dart';

class BrowseWidget extends StatelessWidget {
  const BrowseWidget({super.key, this.subtitle});

  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            'Продолжить просмотр',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 10),
          child: Text(
            subtitle ?? '',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white.withOpacity(0.64)),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 15,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: AspectRatio(
                      aspectRatio: 180 / 100,
                      child: CourseSeriesItem(
                          containerTitle: 'Просмотрено',
                          title: 'Новое видео',
                          time: '20:18 / 20:18',
                          courseStateEnum: CourseStateEnum.NOT_PURCHASED)));
            },
          ),
        ),
      ],
    );
  }
}
