import 'package:flutter/material.dart';
import 'package:info_app/features/courses/presentation/widgets/title_widget.dart';
import 'package:info_app/widget/custom_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      'Настройки',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const TitleWidget(
                    title: 'Тема приложения',
                    subtitle:
                        'Можно изменить тему приложения, кому как нравится :)'),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ButtonWidget(
                            text: 'Светлая сторона',
                            height: 43,
                            color: Colors.white,
                            textColor: Colors.black,
                            boxBorder: Border.all(
                                width: 1,
                                color: Colors.white.withOpacity(0.18)))),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: ButtonWidget(
                      text: 'Тёмная сторона',
                      height: 43,
                      color: Colors.white.withOpacity(0.08),
                      textColor: Colors.white.withOpacity(0.64),
                      boxBorder: Border.all(
                          width: 2, color: Colors.white.withOpacity(0.08)),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const TitleWidget(
                    title: 'Язык приложения',
                    subtitle:
                        'Кто на каком лучше понимает! Мы готовы принять всех клиентов'),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ButtonWidget(
                            text: 'Русский язык',
                            height: 43,
                            color: Colors.white,
                            textColor: Colors.black,
                            boxBorder: Border.all(
                                width: 1,
                                color: Colors.white.withOpacity(0.18)))),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: ButtonWidget(
                      text: 'English language',
                      height: 43,
                      color: Colors.white.withOpacity(0.08),
                      textColor: Colors.white.withOpacity(0.64),
                      boxBorder: Border.all(
                          width: 2, color: Colors.white.withOpacity(0.08)),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
