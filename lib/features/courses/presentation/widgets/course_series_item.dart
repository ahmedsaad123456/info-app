import 'package:flutter/material.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/courses/presentation/widgets/buy_row.dart';
import 'package:info_app/features/courses/presentation/widgets/recommended_container.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/presentation/widgets/video_player_widget.dart';
import 'package:info_app/features/home/domain/entities/material_entity.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';

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
    return GestureDetector(
      onTap: () {
     
        if (materialEntity.filename != null) {
          String type = materialEntity.filename!.split('.').last;
          bool isVideo = type != "png" && type != "jpg" && type != "jpeg";

          if (isVideo) {
               HomeCubit.get(context)
            .setHistories('video_history', materialEntity.id ?? 0);
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => VideoPlayerWidget(
                  videoUrl: BASE_URL_VIDEO + (materialEntity.filename ?? ""),
                ),
              ),
            );

            print(materialEntity.id);
          }
        }
      },
      child: Stack(
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
                        width: 1, color: Colors.white.withOpacity(0.08)))),
            height: 100,
            width: double.infinity,
            child: materialEntity.preview == null
                ? Image.asset(
                    'assets/icons/course2.png',
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    '$BASE_URL_PREVIEW${materialEntity.preview}',
                    fit: BoxFit.fill,
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
                      fontWeight: FontWeight.w500),
                ),
                const Text(
                  '20/18',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
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
      ),
    );
  }
}
