import 'package:info_app/core/constants.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/remote/api_base.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/login_screen/data/models/user_model.dart';

class ApiServiceAuth extends ApiBase {
  Future<UserModel> login(String email, String refCode) async {
    return executeAndHandleErrorServer<UserModel>(() async {
      final response = await post(
        '$BASE_URL/authorize',
        body: {"email": email, "ref_code": refCode},
      );
      return UserModel.fromJson(response.json);
    });
  }

  Future<CodeModel> confirmCode(int accountId, int code) async {
    return executeAndHandleErrorServer<CodeModel>(() async {
      final response = await post(
        '$BASE_URL/code',
        body: {'account_id': accountId, 'code': code},
      );
      return CodeModel.fromJson(response.json);
    });
  }
}
