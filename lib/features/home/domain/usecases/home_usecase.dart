import 'package:dartz/dartz.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/domain/repositories/home_repository.dart';


class HomeUsecase {
  final HomeRepository homeRepository;

  HomeUsecase(this.homeRepository);

  Future<Either<String, CourseResponseModel>> getCourses() async {
    return await homeRepository.getCourses();
  }


}
