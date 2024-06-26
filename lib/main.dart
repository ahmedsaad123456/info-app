import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/core/init_app.dart';
import 'package:info_app/core/shared/components/providers.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/features/first_run_screen/first_run_screen.dart';
import 'package:info_app/features/home/presentation/pages/menu.dart';
import 'package:info_app/locator.dart';

void main() async {
  await InitApp.initialize();

  final cacheHelper = locator<CacheHelper>();

  bool isFirstRun = cacheHelper.getData('firstRun') ?? true;

  if (isFirstRun) {
    await cacheHelper.saveData(key: 'firstRun', value: false);
  }

  token = cacheHelper.getData('token');
  token =
      '8a40cfc63428c614105d066a2a65b1af6e9b40d7cbef007e83597f6c3bbf98ae0ca6ab88ef1925fc9e14ab733a3a8c6de182803270d4ef05ac755a81bb526237';

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
        home: isLoggedIn ? const Menu() : const FirstScreen(),
      ),
    );
  }
}
