import 'package:dartz/dartz.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/features/login_screen/data/datasources/api_service_auth.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/login_screen/data/models/user_model.dart';
import 'package:info_app/features/login_screen/domain/repositories/auth_repository.dart';

class AuthImplRepository implements AuthRepository {
  ApiServiceAuth authService;

  AuthImplRepository(this.authService);

  @override
  Future<Either<String, UserModel>> login(String email, String refCode) {
    return executeAndHandleError<UserModel>(() async {
      final res = await authService.login(email, refCode);
      return res;
    });
  }

  @override
  Future<Either<String, CodeModel>> confirmCode(int account_id, int code) {
    return executeAndHandleError<CodeModel>(() async {

      final res =
          await authService.confirmCode(account_id, code);
      return res;
    });
  }
}
