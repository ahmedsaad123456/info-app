import 'package:flutter/material.dart';
import 'package:info_app/features/courses/widgets/buy_row.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/recommended_container.dart';

class CourseSeriesItem extends StatelessWidget {
  const CourseSeriesItem({
    super.key,
    required this.title,
    required this.time,
    required this.courseStateEnum,
    required this.containerTitle,
  });

  final String title, time, containerTitle;
  final CourseStateEnum courseStateEnum;

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
                      width: 1, color: Colors.white.withOpacity(0.08)))),
          height: 100,
          child: Image.asset(
            'assets/icons/course2.png',
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                time,
                style: const TextStyle(
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
    );
  }
}
