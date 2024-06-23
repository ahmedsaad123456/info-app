import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/data/models/material_model.dart';
import 'package:info_app/features/search/domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    List<CourseModel>? super.courses,
    List<MaterialModel>? super.materials,
    super.skip,
    super.quantity,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <CourseModel>[];
      json['courses'].forEach((v) {
        courses!.add(CourseModel.fromJson(v));
      });
    }
    if (json['materials'] != null) {
      materials = <MaterialModel>[];
      json['materials'].forEach((v) {
        materials!.add(MaterialModel.fromJson(v));
      });
    }
    skip = json['skip'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courses != null) {
      data['courses'] = courses!.map((v) => (v as CourseModel).toJson()).toList();
    }
    if (materials != null) {
      data['materials'] = materials!.map((v) => (v as MaterialModel).toJson()).toList();
    }
    data['skip'] = skip;
    data['quantity'] = quantity;
    return data;
  }
}
