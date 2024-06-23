import 'package:dartz/dartz.dart';
import 'package:info_app/features/courses/data/models/course_view_model.dart';

abstract class CourseRepository {
  Future<Either<String, CourseViewModel>> getCoursesById(int id);
}
