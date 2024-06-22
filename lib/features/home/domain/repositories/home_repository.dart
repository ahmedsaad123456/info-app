import 'package:dartz/dartz.dart';
import 'package:info_app/features/home/data/models/course_model.dart';

abstract class HomeRepository {
  Future<Either<String, CourseResponseModel>> getCourses();
}
