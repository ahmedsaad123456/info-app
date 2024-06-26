import 'package:dartz/dartz.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/data/models/favorites_model.dart';
import 'package:info_app/features/home/data/models/history_model.dart';
import 'package:info_app/features/home/data/models/material_model.dart';
import 'package:info_app/features/home/data/models/story_model.dart';
import 'package:info_app/features/home/domain/entities/request_favorites_entity.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

abstract class HomeRepository {
  Future<Either<String, CourseResponseModel>> getCourses();
  Future<Either<String, ResponseFavoritesModel>> getFavorites();
  Future<Either<String, CodeModel>> setFavorites(
      RequestFavoritesEntity request);
  Future<Either<String, StoryResponseModel>> getStories();
  Future<Either<String, HistoryModel>> getHistories();
  Future<Either<String, HistoryModel>> setHistories(String key, String value);
  Future<Either<String, MaterialResponseModel>> getMaterials();

}
