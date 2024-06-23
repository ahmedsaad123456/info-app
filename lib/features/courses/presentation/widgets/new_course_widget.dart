import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_network/image_network.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/courses/presentation/cubit/course_cubit.dart';
import 'package:info_app/features/courses/presentation/pages/courses_page.dart';
import 'package:info_app/features/courses/presentation/widgets/buy_row.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/presentation/widgets/recommended_container.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';

class NewCourseWidget extends StatefulWidget {
  const NewCourseWidget({
    super.key,
    required this.courseStateEnum,
    this.isNotPlus,
    required this.isBookmark,
    this.title,
    required this.isHistory,
    required this.courseEntity,
  });

  final bool? isNotPlus;
  final bool isBookmark;
  final String? title;
  final bool isHistory;
  final CourseStateEnum courseStateEnum;
  final CourseEntity courseEntity;

  @override
  _NewCourseWidgetState createState() => _NewCourseWidgetState();
}

class _NewCourseWidgetState extends State<NewCourseWidget> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.isBookmark;
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CourseCubit.get(context).getCourse(widget.courseEntity.id ?? 0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CoursesPage(
              courseStateEnum: CourseStateEnum.NOT_PURCHASED,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: widget.courseStateEnum == CourseStateEnum.NOT_PURCHASED
                ? const GradientBoxBorder(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(255, 136, 136, 1),
                        Color.fromRGBO(255, 55, 151, 1),
                      ],
                    ),
                    width: 1,
                  )
                : Border.all(
                    width: 1,
                    color: Colors.white.withOpacity(0.08),
                  ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                    width: widget.isHistory ? double.infinity : 350,
                    child: widget.courseEntity.preview == null
                        ? Image.asset(
                            'assets/icons/course.png',
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            '$BASE_URL_PREVIEW${widget.courseEntity.preview}',
                            fit: BoxFit.fill,
                          )),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseEntity.name ?? '',
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.courseEntity.description ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.64),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 25,
                child: GestureDetector(
                  onTap: toggleBookmark,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: FittedBox(
                      child: Icon(
                        isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        color: isBookmarked
                            ? const Color(0xFFF8206E)
                            : Colors.white.withOpacity(0.64),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.courseStateEnum == CourseStateEnum.NOT_PURCHASED)
                Positioned(
                  top: 20,
                  left: 25,
                  child: BuyRow(
                    isNotPlus: widget.isNotPlus,
                  ),
                )
              else if (widget.courseStateEnum == CourseStateEnum.VIEWED)
                Positioned(
                  top: 20,
                  left: 25,
                  child: RecommendedContainer(
                    title: widget.title ?? '',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
