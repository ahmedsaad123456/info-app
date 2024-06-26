import 'package:flutter/material.dart';
import 'package:info_app/features/courses/presentation/widgets/course_series_item.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/home/domain/entities/material_entity.dart';

class BrowseWidget extends StatelessWidget {
  const BrowseWidget({super.key, this.subtitle, this.title});

  final String? subtitle;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title ?? "",
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10, left: 16),
            child: Text(
              subtitle ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.64)),
            ),
          )
        else
          const SizedBox(
            height: 4,
          ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 15,
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AspectRatio(
                      aspectRatio: 180 / 100,
                      child: CourseSeriesItem(
                          containerTitle: 'Просмотрено',
                          materialEntity: MaterialEntity(),
                          courseStateEnum: CourseStateEnum.PURCHASED)));
            },
          ),
        ),
      ],
    );
  }
}
