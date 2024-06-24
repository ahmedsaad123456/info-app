import 'package:info_app/features/home/domain/entities/material_entity.dart';

class MaterialModel extends MaterialEntity {
  MaterialModel({
    super.id,
    super.courseId,
    super.name,
    super.description,
    super.preview,
    super.filename,
  });

  MaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    name = json['name'];
    description = json['description'];
    preview = json['preview'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['name'] = name;
    data['description'] = description;
    data['preview'] = preview;
    data['filename'] = filename;
    return data;
  }
}

class MaterialResponseModel extends MaterialResponseEntity {
  MaterialResponseModel({
    super.result,
    super.materials,
  });

  MaterialResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['materials'] != null) {
      materials = <MaterialModel>[];
      json['materials'].forEach((v) {
        if (v != null) {
          materials?.add(MaterialModel.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;
    if (materials != null) {
      data['materials'] =
          materials?.map((v) => (v as MaterialModel).toJson()).toList();
    }
    return data;
  }
}
