import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/features/courses/course_state_enum.dart';
import 'package:info_app/features/courses/pages/courses_page.dart';
import 'package:info_app/features/login_screen/presentation/pages/login_page.dart';
import 'package:info_app/widget/custom_button.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/icons/shape.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/logo.svg',
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Image.asset('assets/icons/avatar.png'),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Добро пожаловать!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.84),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        'Меня зовут Инна, я эксперт поподсознанию \nи ваш наставник в приложении.\n Давайте начнём наше путешествие\n к познанию вашего разума',
                        style: (TextStyle(
                            color: Colors.white.withOpacity(0.64),
                            fontSize: 16,
                            fontFamily: 'SuisseIntl',
                            letterSpacing: -0.48)),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 120,
                    ),
                    ButtonWidget(
                      text: 'Продолжить',
                      height: 52,
                      color: const Color.fromRGBO(248, 32, 110, 1),
                      onTap: () {
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                LoginPage(),
                          ),
                        );
                      },
                      textColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.6),
                            letterSpacing: -0.42),
                        children: const [
                          TextSpan(
                              text:
                                  'Нажимая на кнопку «Продолжить», Вы соглашаетесь с '),
                          TextSpan(
                            text: 'Политикой конфиденциальности',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
