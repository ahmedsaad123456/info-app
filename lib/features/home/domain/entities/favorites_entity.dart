import 'package:info_app/features/home/data/models/favorites_model.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';
import 'package:info_app/features/home/domain/entities/material_entity.dart';

class FavoritesEntity {
  List<MaterialEntity>? materials;
  List<CourseEntity>? courses;

  FavoritesEntity({
    this.materials,
    this.courses,
  });
}

class ResponseFavoritesEntity {
  bool? result;
  FavoritesModel? favorites;

  ResponseFavoritesEntity({
    this.result,
    this.favorites,
  });
}
