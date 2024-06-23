import 'package:dartz/dartz.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

abstract class ProfileRepository {
  Future<Either<String, CodeModel>> updateProfile(
      String name, String email, String phone);
  Future<Either<String, CodeModel>> getProfile();
}
