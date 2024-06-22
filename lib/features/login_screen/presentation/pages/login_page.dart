import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/features/login_screen/presentation/cubit/auth_cubit.dart';
import 'package:info_app/features/login_screen/presentation/cubit/auth_state.dart';
import 'package:info_app/features/login_screen/presentation/pages/code_screen.dart';
import 'package:info_app/widget/custom_button.dart';
import 'package:info_app/widget/custom_textfiled.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/icons/shape4.png'))),
      child: Scaffold(
            backgroundColor:  Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => CodeScreen(),
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
                          height: 130,
                        ),
                        const Text(
                          "Авторизация",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Введите номер телефона, чтобы \nиспользовать сервис на любом устройстве',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextField(
                          iconData: SvgPicture.asset('assets/icons/email.svg'),
                          width: 350,
                          controller: authCubit.controller,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: authCubit.changeForm,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "error";
                            }
                            return null;
                          },
                          textHint: 'Электронная почта',
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
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(40)),
                            child: Image.asset('assets/icons/social.png')),
                        const SizedBox(
                          height: 16,
                        ),
                        authCubit.isDisabled 
                            ? ButtonWidget(
                                text: 'Получить код',
                                width: 350,
                                height: 52,
                                color: const Color.fromRGBO(248, 32, 110, 1),
                                textColor: Colors.white.withOpacity(0.48),
                              )
                            : ButtonWidget(
                                text: 'Получить код',
                                height: 52,
                                width: 350,
                                color: Color.fromRGBO(248, 32, 110, 1),
                                textColor: Colors.white,
                                onTap: () {
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate() && !authCubit.isDisabled) {
                                    authCubit.login();
                                  }
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