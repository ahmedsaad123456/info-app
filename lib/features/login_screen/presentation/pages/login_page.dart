import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/core/constants.dart';
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
    var size = MediaQuery.sizeOf(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/icons/shape4.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 32),
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
                      SizedBox(
                        height: size.height * 0.17,
                      ),
                      const Text(
                        "Авторизация",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Введите электронную почту, чтобы\nиспользовать сервис на любом устройстве',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6399999856948853),
                          fontSize: 16,
                          fontFamily: 'SuisseIntl',
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          letterSpacing: -0.48,
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
                      const Spacer(),
                      Text(
                        'Войти с помощью',
                        style: TextStyle(
                            fontSize: 14, color: Colors.white.withOpacity(0.6)),
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
                        height: 24,
                      ),
                      ButtonWidget(
                        text: 'Получить код',
                        height: 52,
                        width: MediaQuery.sizeOf(context).width,
                        color: const Color.fromRGBO(248, 32, 110, 1),
                        textColor: Colors.white,
                        onTap: !authCubit.isDisabled
                            ? () {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate() &&
                                    !authCubit.isDisabled) {
                                  authCubit.login();
                                }
                              }
                            : null,
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
                          children: [
                            const TextSpan(
                                text:
                                    'Нажимая на кнопку «Продолжить», Вы соглашаетесь\nс '),
                            TextSpan(
                                text: 'Политикой конфиденциальности',
                                style: const TextStyle(color: Colors.white),
                                //add on tap
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    openUrl(context);
                                  }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
