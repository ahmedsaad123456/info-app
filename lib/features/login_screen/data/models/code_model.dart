import 'package:info_app/features/home/domain/entities/request_favorites_entity.dart';
import 'package:info_app/features/login_screen/domain/entities/code_entity.dart';

class CodeModel extends CodeEntity {
  CodeModel({super.result, super.account, super.token});

  CodeModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    account =
        json['account'] != null ? AccountModel.fromJson(json['account']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;
    data['account'] = account?.toJson();
    data['token'] = token;
    return data;
  }
}

class AccountModel extends AccountEntity {
  AccountModel({
    super.id,
    super.phone,
    super.name,
    super.email,
    super.avatar,
    super.favorites,
    super.isAdmin,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    // favorites = json['favorites'] != null
    //     ? RequestFavoritesEntity.fromJson(json['favorites'])
    //     : null;
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    // data['favorites'] = favorites?.toJson();
    data['is_admin'] = isAdmin;
    return data;
  }
}
