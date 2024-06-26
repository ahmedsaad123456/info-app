import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:info_app/features/home/presentation/cubit/home_satate.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: cubit.screens[cubit.index],
            ),
          ),
          bottomNavigationBar: Container(
            height: 72,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Colors.white.withOpacity(0.18),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 35, right: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      cubit.changeIndex(0, context);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/search.svg',
                          color: cubit.getIconColor(0),
                        ),
                        5.ph,
                        Text(
                          'Поиск',
                          style: TextStyle(
                            color: cubit.getTextColor(0),
                            fontSize: 12,
                            fontFamily: 'Suisse Intl',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.changeIndex(1, context);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/home.svg',
                          color: cubit.getIconColor(1),
                        ),
                        5.ph,
                        Text(
                          'Главная',
                          style: TextStyle(
                            color: cubit.getTextColor(1),
                            fontSize: 12,
                            fontFamily: 'Suisse Intl',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.changeIndex(2, context);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/profile.svg',
                          color: cubit.getIconColor(2),
                        ),
                        5.ph,
                        Text(
                          'Профиль',
                          style: TextStyle(
                            color: cubit.getTextColor(2),
                            fontSize: 12,
                            fontFamily: 'Suisse Intl',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
