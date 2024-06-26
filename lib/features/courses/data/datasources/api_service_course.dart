import 'package:info_app/core/constants.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/remote/api_base.dart';
import 'package:info_app/features/courses/data/models/course_view_model.dart';

class ApiServiceCourse extends ApiBase {
  Future<CourseViewModel> getCoursesById(int id) async {
    return executeAndHandleErrorServer<CourseViewModel>(() async {
      final response = await get('$BASE_URL/course/$id', headers: {
        'Authorization': token ?? "",
      });
      return CourseViewModel.fromJson(response.json);
    });
  }
}
