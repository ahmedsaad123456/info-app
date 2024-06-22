import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:info_app/features/home/presentation/cubit/home_satate.dart';
import 'package:info_app/features/home/presentation/widgets/browse_widget.dart';
import 'package:info_app/features/home/presentation/widgets/course_by_category.dart';
import 'package:info_app/features/home/presentation/widgets/course_owner_widget.dart';
import 'package:info_app/features/home/presentation/widgets/courses_list_view.dart';
import 'package:info_app/features/home/presentation/widgets/story_list_view.dart';
import 'package:info_app/widget/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeCubit.get(context).getCourses();
        final homeCubit = HomeCubit.get(context);

        return homeCubit.courseModel != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/logo.svg',
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: StoryListView(),
                  ),
                  Image.asset('assets/icons/home3.png'),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Более 500 тысяч человек смогли изменить свою жизнь через работу с подсознанием по уникальной методике Инны ТИ. Благодаря работе с подсознанием, можно быстро и легко изменить все сферы жизни. На платформе вы найдёте более 100 методик. Подписка открывает доступ к огромной базе курсов, семинаров и тренажёров для работы с подсознанием',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.64)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: ButtonWidget(
                        text: 'Оформить подписку',
                        height: 52,
                        width: 350,
                        color: Color(0xFFF8206E),
                        textColor: Colors.white),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const BrowseWidget(),
                  const SizedBox(
                    height: 32,
                  ),
                  CoursesListView(
                    type: 1,
                    courses: homeCubit.demoCourses,
                    title: 'Демо курсы',
                    subtitle:
                        'Авторские курсы, которые доступны всем пользователям нашего приложения',
                    courseStateEnum: CourseStateEnum.PURCHASED,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CoursesListView(
                    type: 2,
                    courses: homeCubit.neroCourses,
                    title: 'Подписка Нейро',
                    subtitle:
                        'Авторские курсы, которые доступны только по подписке Нейро и выше',
                    courseStateEnum: CourseStateEnum.NOT_PURCHASED,
                    isNotPlus: true,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CoursesListView(
                      type: 3,
                      courses: homeCubit.neroPlusCourses,
                      title: 'Подписка Нейро+',
                      subtitle:
                          'Авторские курсы, которые доступны только по подписке Нейро+',
                      courseStateEnum: CourseStateEnum.NOT_PURCHASED),
                  const SizedBox(
                    height: 32,
                  ),
                  const CourseOwnerWidget(),
                  const SizedBox(
                    height: 32,
                  ),
                  const Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Text(
                      'Курсы по категориям',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ...homeCubit.categoryCourseMap.entries.map((entry) {
                    return Column(
                      children: [
                        CourseByCategory(
                          title: entry.key,
                          courses: entry.value,
                          courseStateEnum: CourseStateEnum.VIEWED,
                          isBookmark: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  }).toList(),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}