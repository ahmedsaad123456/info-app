import 'package:info_app/features/home/domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  CourseModel({
    super.id,
    super.name,
    super.category,
    super.type,
    super.description,
    super.preview,
    super.price,
    super.accessLevel,
    super.content,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    type = json['type'];
    description = json['description'];
    preview = json['preview'];
    price = json['price'].toDouble();
    accessLevel = json['access_level'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['type'] = type;
    data['description'] = description;
    data['preview'] = preview;
    data['price'] = price;
    data['access_level'] = accessLevel;
    data['content'] = content;
    return data;
  }
}

class CourseResponseModel extends CourseResponseEntity {
  CourseResponseModel({super.result, super.courses});

  CourseResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['courses'] != null) {
      courses = [];
      json['courses'].forEach((v) {
        courses?.add(CourseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;
    if (courses != null) {
      data['courses'] =
          courses?.map((v) => (v as CourseModel).toJson()).toList();
    }
    return data;
  }
}
