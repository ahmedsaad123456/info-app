import 'package:flutter/material.dart';
import 'package:info_app/features/courses/widgets/course_series_item.dart';
import 'package:info_app/features/courses/course_state_enum.dart';

class VideoSearch extends StatelessWidget {
  const VideoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            'Нашли видео',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 15,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: AspectRatio(
                      aspectRatio: 180 / 100,
                      child: CourseSeriesItem(
                          containerTitle: 'Просмотрено',
                          title: 'Новое видео',
                          time: '20:18 / 20:18',
                          courseStateEnum: CourseStateEnum.PURCHASED)));
            },
          ),
        ),
      ],
    );
  }
}
