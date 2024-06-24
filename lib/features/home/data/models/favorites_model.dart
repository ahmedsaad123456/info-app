import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/data/models/material_model.dart';
import 'package:info_app/features/home/domain/entities/favorites_entity.dart';

class FavoritesModel extends FavoritesEntity {
  FavoritesModel({super.courses, super.materials});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    if (json['materials'] != null) {
      materials = <MaterialModel>[];
      json['materials'].forEach((v) {
        if (v != null) {
          materials?.add(MaterialModel.fromJson(v));
        }
      });
    }
    if (json['courses'] != null) {
      courses = <CourseModel>[];
      json['courses'].forEach((v) {
        if (v != null) {
          courses?.add(CourseModel.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (materials != null) {
      data['materials'] =
          materials?.map((v) => (v as MaterialModel).toJson()).toList();
    }
    if (courses != null) {
      data['courses'] =
          courses?.map((v) => (v as CourseModel).toJson()).toList();
    }
    return data;
  }
}

class ResponseFavoritesModel extends ResponseFavoritesEntity {
  ResponseFavoritesModel({
    super.result,
    super.favorites,
  });

  ResponseFavoritesModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    favorites = json['favorites'] != null
        ? FavoritesModel.fromJson(json['favorites'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['favorites'] = favorites?.toJson();
    return data;
  }
}
