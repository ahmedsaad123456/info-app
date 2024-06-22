import 'package:dartz/dartz.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/login_screen/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel>> login(String email, String refCode);
  Future<Either<String, CodeModel>> confirmCode(int account_id, int code);
}
