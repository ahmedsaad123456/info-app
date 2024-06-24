import 'package:info_app/features/home/domain/entities/material_entity.dart';

class CourseEntity {
  int? id;
  String? name;
  String? category;
  String? type;
  String? description;
  dynamic preview;
  double? price;
  int? accessLevel;
  bool? isFavorite;
  dynamic content;
  final List<MaterialEntity>? materials;
  CourseEntity({
    this.id,
    this.name,
    this.category,
    this.type,
    this.description,
    this.preview,
    this.price,
    this.accessLevel,
    this.isFavorite,
    this.content,
    this.materials,
  });
}

class CourseResponseEntity {
  bool? result;
  List<CourseEntity>? courses;

  CourseResponseEntity({
    this.result,
    this.courses,
  });
}
