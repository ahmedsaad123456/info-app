import 'package:dartz/dartz.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/features/home/data/datasources/api_service_home.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/data/models/favorites_model.dart';
import 'package:info_app/features/home/domain/entities/request_favorites_entity.dart';
import 'package:info_app/features/home/domain/repositories/home_repository.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

class HomeImplRepository implements HomeRepository {
  ApiServiceHome homeService;

  HomeImplRepository(this.homeService);

  @override
  Future<Either<String, CourseResponseModel>> getCourses() {
    return executeAndHandleError<CourseResponseModel>(() async {
      final res = await homeService.getCourses();
      return res;
    });
  }

  @override
  Future<Either<String, ResponseFavoritesModel>> getFavorites() {
    return executeAndHandleError<ResponseFavoritesModel>(() async {
      final res = await homeService.getFavorites();
      return res;
    });
  }

  @override
  Future<Either<String, CodeModel>> setFavorites(RequestFavoritesEntity request) {
    return executeAndHandleError<CodeModel>(() async {
      final res = await homeService.setFavorites(request);
      return res;
    });
  }
}
