import 'package:info_app/features/home/domain/entities/course_entity.dart';
import 'package:info_app/features/home/domain/entities/material_entity.dart';

class SearchEntity {
  List<CourseEntity>? courses;
  List<MaterialEntity>? materials;
  int? skip;
  int? quantity;

  SearchEntity({
    this.courses,
    this.materials,
    this.skip,
    this.quantity,
  });
}
