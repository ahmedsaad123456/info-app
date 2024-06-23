import 'package:dartz/dartz.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/features/courses/data/datasources/api_service_course.dart';
import 'package:info_app/features/courses/data/models/course_view_model.dart';
import 'package:info_app/features/courses/domain/repositories/course_repository.dart';
import 'package:info_app/features/home/data/models/course_model.dart';

class CourseImplRepository implements CourseRepository {
  ApiServiceCourse apiServiceCourse;

  CourseImplRepository(this.apiServiceCourse);

  @override
  Future<Either<String, CourseViewModel>> getCoursesById(int id) {
    return executeAndHandleError<CourseViewModel>(() async {
      final res = await apiServiceCourse.getCoursesById(id);
      return res;
    });
  }
}
