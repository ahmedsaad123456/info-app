import 'package:info_app/core/constants.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/remote/api_base.dart';
import 'package:info_app/features/home/data/models/course_model.dart';

class ApiServiceHome extends ApiBase {
  Future<CourseResponseModel> getCourses() async {
    return executeAndHandleErrorServer<CourseResponseModel>(() async {
      final response = await get('$BASE_URL/courses', headers: {
        'Authorization': token ?? "",
      });
      return CourseResponseModel.fromJson(response.json);
    });
  }
}
