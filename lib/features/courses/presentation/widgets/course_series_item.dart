import 'package:flutter/material.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/courses/presentation/widgets/buy_row.dart';
import 'package:info_app/features/courses/presentation/widgets/recommended_container.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/presentation/widgets/video_player_widget.dart';
import 'package:info_app/features/home/domain/entities/material_entity.dart';
import 'package:video_player/video_player.dart';
import 'package:web_video_player/player.dart';

class CourseSeriesItem extends StatelessWidget {
  const CourseSeriesItem({
    super.key,
    required this.courseStateEnum,
    required this.containerTitle,
    required this.materialEntity,
  });

  final String containerTitle;
  final CourseStateEnum courseStateEnum;
  final MaterialEntity materialEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
            gradient: courseStateEnum == CourseStateEnum.NOT_PURCHASED
                ? const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Color.fromRGBO(255, 136, 136, 1),
                      Color.fromRGBO(255, 55, 151, 1),
                    ],
                  )
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          height: 100,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const VideoPlayerWidget(
                    videoUrl:
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                  ),
                ),
              );
            },
            child: const Stack(
              children: [
                WebVideoPlayer(
                  url:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                  autoPlay: false,
                ),
                Positioned.fill(child: SizedBox()),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                materialEntity.name ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        courseStateEnum == CourseStateEnum.NOT_PURCHASED
            ? const Positioned(
                top: 10,
                left: 10,
                child: BuyRow(),
              )
            : courseStateEnum == CourseStateEnum.VIEWED
                ? Positioned(
                    top: 10,
                    left: 10,
                    child: RecommendedContainer(
                      title: containerTitle,
                    ),
                  )
                : const SizedBox(),
      ],
    );
  }
}
