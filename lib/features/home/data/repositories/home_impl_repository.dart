import 'package:dartz/dartz.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/features/home/data/datasources/api_service_home.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/domain/repositories/home_repository.dart';


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
}
