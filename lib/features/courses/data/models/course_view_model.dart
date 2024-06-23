import 'package:info_app/features/home/data/models/course_model.dart';

class CourseViewModel {
  CourseViewModel({this.result, this.courseModel});
  CourseModel? courseModel;
  bool? result;

  CourseViewModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    courseModel =
        json['course'] != null ? CourseModel.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;

    return data;
  }
}
