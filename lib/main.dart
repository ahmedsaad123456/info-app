import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/core/init_app.dart';
import 'package:info_app/core/shared/components/providers.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/features/first_run_screen/first_run_screen.dart';
import 'package:info_app/features/home/presentation/pages/menu.dart';
import 'package:info_app/features/login_screen/presentation/pages/login_page.dart';
import 'package:info_app/locator.dart';

void main() async {
  await InitApp.initialize();

  final cacheHelper = locator<CacheHelper>();

  bool isFirstRun = cacheHelper.getData('firstRun') ?? true;

  if (isFirstRun) {
    await cacheHelper.saveData(key: 'firstRun', value: false);
  }

  token = cacheHelper.getData('token');

  runApp(MyApp(
    isFirstRun: isFirstRun,
    isLoggedIn: token == null ? false : true,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstRun, required this.isLoggedIn});

  final bool isFirstRun, isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'SuisseIntl'),
        home: isFirstRun
            ? const FirstScreen()
            : isLoggedIn
                ? const Menu()
                : const FirstScreen(),
        // home: LoginPage(),
      ),
    );
  }
}
