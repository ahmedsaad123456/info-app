import 'package:dartz/dartz.dart';
import 'package:info_app/features/courses/data/models/course_view_model.dart';
import 'package:info_app/features/courses/domain/repositories/course_repository.dart';

class CourseUseCase {
  final CourseRepository courseRepository;

  CourseUseCase(this.courseRepository);

  Future<Either<String, CourseViewModel>> getCourses(int id) async {
    return await courseRepository.getCoursesById(id);
  }
}
