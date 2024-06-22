import 'package:info_app/features/login_screen/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({super.result, super.code, super.account_id});

  UserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    code = json['code'];
    account_id = json['account_id'];

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;
    data['code'] = code;
    data['account_id'] = account_id;
    return data;
  }
}
