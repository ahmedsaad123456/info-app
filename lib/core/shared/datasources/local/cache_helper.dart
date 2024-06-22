import 'dart:convert';

import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    try {
      print(5);
      if (value is String) {
        return await sharedPreferences!.setString(key, value);
      }
      if (value is int) return await sharedPreferences!.setInt(key, value);
      if (value is bool) return await sharedPreferences!.setBool(key, value);

      return await sharedPreferences!.setDouble(key, value);
    } catch (e) {
      print(7);
      rethrow;
    }
  }

  dynamic getData(
    String key,
  ) {
    try {
      print("1");
      return sharedPreferences!.get(key);
    } catch (e) {
      print("2");
      return null;
    }
  }

  Future<bool> removeData({
    required String key,
  }) async {
    try {
      return await sharedPreferences!.remove(key);
    } catch (e) {
      rethrow;
    }
  }

  Future clearData() async {
    try {
      await sharedPreferences?.clear();
    } catch (e) {
      rethrow;
    }
  }

  Future saveUser(CodeModel userModel) async {
    String jsonString = json.encode(userModel.toJson());
    await saveData(key: 'user', value: jsonString);
  }

  Future<CodeModel?> getUser() async {
    String? jsonString = await getData('user');
    if (jsonString != null) {
      var res = CodeModel.fromJson(json.decode(jsonString));
      return res;
    } else {
      return null;
    }
  }

  Future removeUser() async {
    await removeData(key: 'user');
  }
}
