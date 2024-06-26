import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/core/constants.dart';
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
    var size = MediaQuery.sizeOf(context);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/icons/shape4.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: SafeArea(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is CodeSuccessState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const Menu(),
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
                      SizedBox(
                        height: size.height * 0.17,
                      ),
                      const Text(
                        "Введите код",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Для подтверждения входа в приложение мы отправили вам код по электронной почте',
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
                      PinputWidget(
                        // controller: authCubit.pinPutontroller,
                        onChanged: authCubit.changePinput,
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
                              color: Colors.black.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset('assets/icons/social.png')),
                      const SizedBox(
                        height: 24,
                      ),
                      authCubit.isPinputDisabled
                          ? ButtonWidget(
                              text: 'Продолжить',
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
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    openUrl(context);
                                  }),
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
    );
  }
}
