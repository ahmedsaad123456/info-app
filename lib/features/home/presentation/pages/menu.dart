import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                  child: cubit.screens[cubit.index]),
            ),
          ),
         bottomNavigationBar: Container(
           height: 72,
           decoration: BoxDecoration(
             border: Border(
               top: BorderSide(
                 width: 1.0,
                 color: Colors.white.withOpacity(0.18),
               ),
             ),
           ),
           
           child: BottomNavigationBar(
            
             backgroundColor: Colors.white.withOpacity(0.18),
             currentIndex: cubit.index,
             onTap: (index) {
               cubit.changeIndex(index, context);
             },
             items:  [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      color: cubit.getIconColor(0),
                    ),
                  ),
                  label: 'Поиск',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SvgPicture.asset(
                      'assets/icons/home.svg',
                      color: cubit.getIconColor(1),
                    ),
                  ),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SvgPicture.asset(
                      'assets/icons/profile.svg',
                      color: cubit.getIconColor(2),
                    ),
                  ),
                  label: 'Профиль',
                ),
              ],
             selectedIconTheme: const IconThemeData(color: Color(0xFFF8206E)),
             selectedItemColor: const Color(0xFFF8206E),
             selectedFontSize: 12,
             unselectedIconTheme: const IconThemeData(color: Colors.white),
             unselectedItemColor: Colors.white.withOpacity(0.64),
             unselectedFontSize: 12,
           ),
         ),
        );
      },
    );
  }
}
