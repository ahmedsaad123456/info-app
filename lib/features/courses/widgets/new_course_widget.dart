import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_network/image_network.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/courses/widgets/buy_row.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/widgets/recommended_container.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/features/home/presentation/cubit/home_satate.dart';

class NewCourseWidget extends StatelessWidget {
  const NewCourseWidget({
    super.key,
    required this.courseStateEnum,
    this.isNotPlus,
    this.title,
    required this.isHistory,
    required this.courseEntity, this.isSearch,
  });

  final bool? isNotPlus;
  final String? title;
  final bool isHistory;
  final CourseStateEnum courseStateEnum;
  final CourseEntity courseEntity;
  final bool? isSearch;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final homeCubit = HomeCubit.get(context);

        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              border: courseStateEnum == CourseStateEnum.NOT_PURCHASED
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
                      width: isHistory ? double.infinity : 350,
                      child: courseEntity.preview == null
                          ? Image.asset(
                              'assets/icons/course.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              '$BASE_URL_PREVIEW${courseEntity.preview}',
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
                        courseEntity.name ?? '',
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        courseEntity.description ?? '',
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
                    onTap: () {
                      homeCubit.setFavorites(courseEntity.id ?? 0 , isSearch: isSearch ?? false, context: context );
                    },
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: FittedBox(
                        child: Icon(
                          courseEntity.isFavorite ?? false
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                          color: courseEntity.isFavorite ?? false
                              ? const Color(0xFFF8206E)
                              : Colors.white.withOpacity(0.64),
                        ),
                      ),
                    ),
                  ),
                ),
                if (courseStateEnum == CourseStateEnum.NOT_PURCHASED)
                  Positioned(
                    top: 20,
                    left: 25,
                    child: BuyRow(
                      isNotPlus: isNotPlus,
                    ),
                  )
                else if (courseStateEnum == CourseStateEnum.VIEWED)
                  Positioned(
                    top: 20,
                    left: 25,
                    child: RecommendedContainer(
                      title: title ?? '',
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
