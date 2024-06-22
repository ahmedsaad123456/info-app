import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/features/home/presentation/pages/menu.dart';
import 'package:info_app/features/login_screen/presentation/cubit/auth_cubit.dart';
import 'package:info_app/features/login_screen/presentation/cubit/auth_state.dart';
import 'package:info_app/features/login_screen/presentation/widgets/pinput_widget.dart';


import '../../../../widget/custom_button.dart';

class CodeScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CodeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/icons/shape4.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: SafeArea(
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                   if (state is CodeSuccessState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => Menu(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
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
                        const Text(
                          "Введите код",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Для подтверждения входа в приложение мы отправили вам код по электронной почте',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        PinputWidget(
                          controller: authCubit.pinPutontroller,
                          onChanged: authCubit.changePinput,
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Text(
                          'Войти с помощью',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.6)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(40)),
                            child: Image.asset('assets/icons/social.png')),
                        const SizedBox(
                          height: 16,
                        ),
                        authCubit.isPinputDisabled
                            ? ButtonWidget(
                                text: 'Получить код',
                                height: 52,
                                color: const Color.fromRGBO(248, 32, 110, 1),
                                textColor: Colors.white.withOpacity(0.48),
                              )
                            : ButtonWidget(
                                text: 'Получить код',
                                height: 52,
                                color: const Color.fromRGBO(248, 32, 110, 1),
                                textColor: Colors.white,
                                onTap: () {
                                  authCubit.confirmCode();
                          
                                },
                              ),
                        const SizedBox(
                          height: 26,
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
