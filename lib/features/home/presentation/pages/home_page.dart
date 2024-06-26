import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:info_app/features/home/presentation/cubit/home_satate.dart';
import 'package:info_app/features/home/presentation/widgets/browse_widget.dart';
import 'package:info_app/features/home/presentation/widgets/course_by_category.dart';
import 'package:info_app/features/home/presentation/widgets/course_owner_widget.dart';
import 'package:info_app/features/home/presentation/widgets/courses_list_view.dart';
import 'package:info_app/features/home/presentation/widgets/story_list_view.dart';
import 'package:info_app/features/subscription/subscripe_page.dart';
import 'package:info_app/widget/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final homeCubit = HomeCubit.get(context);
        return homeCubit.courseModel != null
            ? Padding(
                padding: const EdgeInsets.only(top: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: StoryListView(
                        stories: homeCubit.stories,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/home3.png',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            'Более 500 тысяч человек смогли изменить свою жизнь через работу с подсознанием по уникальной методике Инны ТИ. Благодаря работе с подсознанием, можно быстро и легко изменить все сферы жизни. На платформе вы найдёте более 100 методик. Подписка открывает доступ к огромной базе курсов, семинаров и тренажёров для работы с подсознанием',
                            style: TextStyle(
                              color:
                                  Colors.white.withOpacity(0.6399999856948853),
                              fontSize: 16,
                              fontFamily: 'SuisseIntl',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                              letterSpacing: -0.48,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: ButtonWidget(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const SubscribeScreen(),
                                    ),
                                  );
                                },
                                text: 'Оформить подписку',
                                height: 52,
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                color: const Color(0xFFF8206E),
                                textColor: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    32.ph,
                    if(homeCubit.materialsHistories != null) 
                    BrowseWidget(
                      materials:homeCubit.materialsHistories ?? [] ,
                      title: 'Продолжить просмотр',
                    ),
                    32.ph,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CourseByCategory(
                                title: entry.key,
                                courses: entry.value,
                                courseStateEnum: CourseStateEnum.NOT_PURCHASED,
                                isBookmark: true,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
