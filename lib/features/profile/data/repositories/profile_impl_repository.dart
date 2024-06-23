import 'package:dartz/dartz.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/profile/data/datasources/api_service_profile.dart';
import 'package:info_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileImplRepository implements ProfileRepository {
  ApiserviceProfile profileService;

  ProfileImplRepository(this.profileService);

  @override
  Future<Either<String, CodeModel>> updateProfile(
      String name, String email, String phone) {
    return executeAndHandleError<CodeModel>(() async {
      final res = await profileService.updateProfile(name, email, phone);
      return res;
    });
  }

  @override
  Future<Either<String, CodeModel>> getProfile() {
    return executeAndHandleError<CodeModel>(() async {
      final res = await profileService.getProfile();
      return res;
    });
  }
}
