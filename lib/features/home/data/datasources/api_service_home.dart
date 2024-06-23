import 'package:info_app/core/constants.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/remote/api_base.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/data/models/favorites_model.dart';
import 'package:info_app/features/home/domain/entities/request_favorites_entity.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

class ApiServiceHome extends ApiBase {
  Future<CourseResponseModel> getCourses() async {
    return executeAndHandleErrorServer<CourseResponseModel>(() async {
      final response = await get('$BASE_URL/courses', headers: {
        'Authorization': token ?? "",
      });
      return CourseResponseModel.fromJson(response.json);
    });
  }

  Future<ResponseFavoritesModel> getFavorites() async {
    return executeAndHandleErrorServer<ResponseFavoritesModel>(() async {
      final response = await get('$BASE_URL/account/favorites', headers: {
        'Authorization': token ?? "",
      });
      return ResponseFavoritesModel.fromJson(response.json);
    });
  }

  Future<CodeModel> setFavorites(RequestFavoritesEntity request) async {
    return executeAndHandleErrorServer<CodeModel>(() async {
      final response = await post('$BASE_URL/account/favorites', body: {
        'favorites': request.toJson()
      }, headers: {
        'Authorization': token ?? "",
      });
      return CodeModel.fromJson(response.json);
    });
  }
}
