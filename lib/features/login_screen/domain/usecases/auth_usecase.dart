import 'package:dartz/dartz.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/login_screen/data/models/user_model.dart';
import 'package:info_app/features/login_screen/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<String, UserModel>> login(String email, String refCode) async {
    return await _authRepository.login(email, refCode);
  }

  Future<Either<String, CodeModel>> confirmCode(int account_id, int code) async {
    return await _authRepository.confirmCode(account_id, code);
  }
}
