import 'package:flutter/material.dart';
import 'package:info_app/features/subscription/payment_page.dart';

import '../../widget/custom_button.dart';
import '../../widget/subscripe_widget.dart';
import 'model.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  int _selectedIndex = 0; // Set default selected index
  SubscriptionData _selectedData = SubscriptionData(
      text: 'Демо',
      cost: '\$0',
      description: 'Доступ к бесплатным\nматериалам');
  void _onWidgetTap(int index, SubscriptionData data) {
    setState(() {
      _selectedIndex = index;
      _selectedData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.none,
          image: AssetImage('assets/icons/shape.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
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
                        'Выбор подписки',
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Смотри 200+ тренажёров и курсов с подпиской ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.84,
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                        TextSpan(
                          text: 'Нейро',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.48),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Хотите получить максимум от нашего приложения? Подписавшись, Вы получаете полный доступ ко всем вебинарам и курсам без каких‑либо ограничений!',
                    style: TextStyle(
                        color: Colors.white.withOpacity(
                          0.64,
                        ),
                        fontSize: 16,
                        letterSpacing: -0.48),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 61,
                  ),
                  Row(
                    children: [
                      SubscripeWidget(
                        color: Colors.white,
                        text: 'Демо',
                        cost: '\$0',
                        description: 'Доступ к бесплатным\nматериалам',
                        onTap: () => _onWidgetTap(
                            0,
                            SubscriptionData(
                                text: 'Демо',
                                cost: '\$0',
                                description:
                                    'Доступ к бесплатным\nматериалам')),
                        selected: _selectedIndex == 0,
                        textColor: Colors.white.withOpacity(0.48),
                        width: 160,
                        height: 180,
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                      SubscripeWidget(
                        color: Colors.white,
                        text: 'Нейро',
                        cost: '\$49',
                        description: 'Материалы\nдля саморазвития',
                        onTap: () => _onWidgetTap(
                            1,
                            SubscriptionData(
                                text: 'Нейро',
                                cost: '\$49',
                                description: 'Материалы\nдля саморазвития')),
                        selected: _selectedIndex == 1,
                        textColor: Colors.white.withOpacity(0.48),
                        width: 160,
                        height: 180,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SubscripeWidget(
                    color: Colors.white,
                    text: 'Нейро+',
                    cost: '\$149',
                    description:
                        'Профессиональные материалы для саморазвития и обучения',
                    onTap: () => _onWidgetTap(
                        2,
                        SubscriptionData(
                            text: 'Нейро+',
                            cost: '\$149',
                            description:
                                'Профессиональные материалы для саморазвития и обучения')),
                    selected: _selectedIndex == 2,
                    textColor: Colors.red,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _selectedData != null
                      ? ButtonWidget(
                          text: 'Перейти к оформлению',
                          height: 52,
                          color: const Color.fromRGBO(248, 32, 110, 1),
                          textColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      PaymentPage(data: _selectedData),
                                ));
                          },
                          gradient: const LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color.fromRGBO(255, 136, 136, 1),
                              Color.fromRGBO(255, 55, 151, 1),
                            ],
                          ),
                        )
                      : ButtonWidget(
                          text: 'Перейти к оформлению',
                          height: 52,
                          color: const Color.fromRGBO(248, 32, 110, 1),
                          textColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      PaymentPage(data: _selectedData),
                                ));
                          },
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(255, 55, 151, 1),
                              Color.fromRGBO(255, 136, 136, 1),
                            ],
                          ),
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
                          letterSpacing: -0.56),
                      children: const [
                        TextSpan(
                            text:
                                'Нажимая на кнопку «Перейти к оформлению», Вы соглашаетесь с'),
                        TextSpan(
                          text: 'Политикой конфиденциальности',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
