

import 'package:info_app/core/constants.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/remote/api_base.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

class ApiserviceProfile extends ApiBase {

  Future<CodeModel> updateProfile(String name, String email , String phone) async {
    return executeAndHandleErrorServer<CodeModel>(() async {
      final response = await patch(
        '$BASE_URL/account',
        body:{
          'name': name,
          'email': email,
          'phone': phone,
        } ,
        headers: {
          'Authorization' : token!,
        }
      );
      return CodeModel.fromJson(response.json);
    });
  }


}
