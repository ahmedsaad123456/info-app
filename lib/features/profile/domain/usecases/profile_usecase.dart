import 'package:dartz/dartz.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileUsecase {
  final ProfileRepository _profileRepository;

  ProfileUsecase(this._profileRepository);

  Future<Either<String, CodeModel>> updateProfile(
      String name, String email, String phone) async {
    return await _profileRepository.updateProfile(name, email, phone);
  }

  Future<Either<String, CodeModel>> getProfile() async {
    return await _profileRepository.getProfile();
  }
}
