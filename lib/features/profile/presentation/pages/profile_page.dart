import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_network/image_network.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/home/presentation/widgets/browse_widget.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/login_screen/presentation/pages/login_page.dart';
import 'package:info_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:info_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:info_app/features/profile/presentation/widgets/selected_widget.dart';
import 'package:info_app/widget/custom_button.dart';
import 'package:info_app/widget/custom_textfiled.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final maskFormatter = MaskTextInputFormatter(
    mask: '+7(###)###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileCubit.get(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccessState) {
          // print('ooooooopppppppppppppppppqwwwwwwwwwwww');
        }
      },
      builder: (context, state) {
        CodeModel? model = ProfileCubit.get(context).codeModel;
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Профиль',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SuisseIntl'),
                  children: [
                    TextSpan(
                      text: model?.account?.name ?? '',
                      style: const TextStyle(color: Color(0xFFF8206E)),
                    ),
                    const TextSpan(
                        text: ', доброе утро! ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Suisse Intl',
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                profileCubit.pickImage();
              },
              child: model?.account?.avatar != null
                  ? ClipOval(
                      child: Image.network(
                        "$BASE_URL_AVATAR${model!.account!.avatar!}",
                        fit: BoxFit.fill,
                        height: 96,
                        width: 96,
                      ),
                    )
                  : Image.asset('assets/icons/avatar.png'),
            ),
            // Image.asset('assets/icons/avatar.png'),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomTextField(
                    inputFormatters: [maskFormatter],
                    onChanged: (v) {
                      if (!v.startsWith('+7')) {
                        profileCubit.phoneController.text =
                            '+7${v.replaceAll('+7', '')}';
                        profileCubit.phoneController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset: profileCubit.phoneController.text.length),
                        );
                      }
                    },
                    controller: profileCubit.phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "error";
                      }
                      return null;
                    },
                    textHint: '+7 (909)-999-99-99',
                    iconData: SvgPicture.asset('assets/icons/phone.svg'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: profileCubit.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textHint: 'email@mail.ru',
                    iconData: SvgPicture.asset('assets/icons/email.svg'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtonWidget(
                    text: 'Редактировать',
                    height: 52,
                    color: Colors.white.withOpacity(0.12),
                    textColor: Colors.white.withOpacity(0.84),
                    boxBorder: Border.all(
                        width: 1, color: Colors.white.withOpacity(0.08)),
                    onTap: () {
                      profileCubit.updateProfile();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 32,
            ),
            const BrowseWidget(
              title: 'Продолжить просмотр',
              subtitle:
                  'Здесь ты найдёшь видео, которые ты уже начал смотреть и приостановился',
            ),
            const SizedBox(
              height: 32,
            ),
            const SelectedWidget(),
            const SizedBox(
              height: 32,
            ),
            GestureDetector(
              onTap: () {
                ProfileCubit.get(context).signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                'Выйти из акккаунта',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.64),
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text('Удалить аккаунта',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.64),
                    fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
