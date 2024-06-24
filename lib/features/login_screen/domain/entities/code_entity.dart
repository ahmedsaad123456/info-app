import 'package:info_app/features/home/domain/entities/request_favorites_entity.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

class CodeEntity {
  bool? result;
  AccountModel? account;
  String? token;

  CodeEntity({this.result, this.account, this.token});
}

class AccountEntity {
  int? id;
  String? phone;
  String? name;
  String? email;
  String? avatar;
  RequestFavoritesEntity? favorites;
  int? isAdmin;


  AccountEntity({
    this.id,
    this.phone,
    this.name,
    this.email,
    this.avatar,
    this.favorites,
    this.isAdmin,

  });
}
