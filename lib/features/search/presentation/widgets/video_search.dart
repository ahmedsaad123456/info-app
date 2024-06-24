import 'package:flutter/material.dart';
import 'package:info_app/features/courses/presentation/widgets/course_series_item.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/home/domain/entities/material_entity.dart';

class VideoSearch extends StatelessWidget {
  const VideoSearch({super.key, required this.materials});

  final List<MaterialEntity> materials;

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
            itemCount: materials.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 0),
            itemBuilder: (context, index) {
              return AspectRatio(
                  aspectRatio: 180 / 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: CourseSeriesItem(
                        containerTitle: 'Просмотрено',
                        materialEntity: materials[index],
                        courseStateEnum: CourseStateEnum.PURCHASED),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
