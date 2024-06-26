import 'package:dartz/dartz.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/data/models/favorites_model.dart';
import 'package:info_app/features/home/data/models/history_model.dart';
import 'package:info_app/features/home/data/models/material_model.dart';
import 'package:info_app/features/home/data/models/story_model.dart';
import 'package:info_app/features/home/domain/entities/request_favorites_entity.dart';
import 'package:info_app/features/home/domain/repositories/home_repository.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

class HomeUsecase {
  final HomeRepository homeRepository;

  HomeUsecase(this.homeRepository);

//================================================================================================================================

  Future<Either<String, CourseResponseModel>> getCourses() async {
    return await homeRepository.getCourses();
  }

//================================================================================================================================

  Future<Either<String, ResponseFavoritesModel>> getFavorites() async {
    return await homeRepository.getFavorites();
  }

//================================================================================================================================

  Future<Either<String, CodeModel>> setFavorites(
      RequestFavoritesEntity request) async {
    return await homeRepository.setFavorites(request);
  }

//================================================================================================================================
  Future<Either<String, StoryResponseModel>> getStories() async {
    return await homeRepository.getStories();
  }

//================================================================================================================================
  Future<Either<String, HistoryModel>> getHistories() async {
    return await homeRepository.getHistories();
  }

//================================================================================================================================
  Future<Either<String, HistoryModel>> setHistories(
      String key, String value) async {
    return await homeRepository.setHistories(key, value);
  }

//================================================================================================================================
  Future<Either<String, MaterialResponseModel>> getMaterials() async {
    return await homeRepository.getMaterials();
  }
}
