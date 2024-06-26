import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/features/profile/presentation/pages/about_page.dart';
import 'package:info_app/features/profile/presentation/pages/bookmarked_courses_page.dart';
import 'package:info_app/features/profile/presentation/widgets/custom_container.dart';
import 'package:info_app/features/profile/presentation/pages/history_courses_page.dart';
import 'package:info_app/features/subscription/subscripe_page.dart';

class SelectedWidget extends StatelessWidget {
  const SelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Разделы профиля',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Тут ты найдёшь все полезные функции для управления приложением',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white.withOpacity(0.64)),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        CustomContainer(
          icon: const Icon(
            Icons.credit_card,
            color: Colors.white,
          ),
          title: 'Подписки',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const SubscribeScreen(),
              ),
            );
          },
        ),
        CustomContainer(
          icon: const Icon(
            Icons.bookmark_border,
            color: Colors.white,
          ),
          title: 'Избранные курсы',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    const BookmarkedCoursesPage(),
              ),
            );
          },
        ),
        CustomContainer(
          icon: const Icon(
            Icons.history,
            color: Colors.white,
          ),
          title: 'История просмотра',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HistoryCoursesPage(),
              ),
            );
          },
        ),
        CustomContainer(
          icon: SvgPicture.asset('assets/icons/page_info.svg'),
          title: 'Настройки',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const AboutPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
