import 'package:flutter/material.dart';
import 'package:info_app/widget/custom_button.dart';
import 'package:info_app/features/courses/course_state_enum.dart';

class CourseButton extends StatelessWidget {
  const CourseButton({super.key, required this.courseStateEnum});

  final CourseStateEnum courseStateEnum;

  @override
  Widget build(BuildContext context) {
    return courseStateEnum == CourseStateEnum.PURCHASED
        ? const ButtonWidget(
            text: 'Смотреть',
            height: 52,
            color: Color(0xFFF8206E),
            textColor: Colors.white)
        : courseStateEnum == CourseStateEnum.NOT_PURCHASED
            ? const ButtonWidget(
                text: 'Приобрести Нейро',
                height: 52,
                color: Color.fromRGBO(248, 32, 110, 1),
                textColor: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color.fromRGBO(255, 136, 136, 1),
                    Color.fromRGBO(255, 55, 151, 1),
                  ],
                ),
              )
            : const ButtonWidget(
                text: 'Порекомендовать',
                height: 52,
                color: Colors.white,
                textColor: Colors.black);
  }
}
