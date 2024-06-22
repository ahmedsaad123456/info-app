import 'dart:io';

import 'package:flutter/material.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/locator.dart';


class InitApp {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await CacheHelper.init();
    HttpOverrides.global = MyHttpOverrides();
    await setupLocator();
  }
}

//best way for ssl certification problem on all http requests
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    try {
      return super.createHttpClient(context)
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
