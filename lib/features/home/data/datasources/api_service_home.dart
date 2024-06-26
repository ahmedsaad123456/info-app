import 'package:info_app/core/constants.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/remote/api_base.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/data/models/favorites_model.dart';
import 'package:info_app/features/home/data/models/history_model.dart';
import 'package:info_app/features/home/data/models/material_model.dart';
import 'package:info_app/features/home/data/models/story_model.dart';
import 'package:info_app/features/home/domain/entities/request_favorites_entity.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

class ApiServiceHome extends ApiBase {
//=================================================================================================================================

  Future<CourseResponseModel> getCourses() async {
    return executeAndHandleErrorServer<CourseResponseModel>(() async {
      final response = await get('$BASE_URL/courses', headers: {
        'Authorization': token ?? "",
      });
      return CourseResponseModel.fromJson(response.json);
    });
  }

//=================================================================================================================================

  Future<ResponseFavoritesModel> getFavorites() async {
    return executeAndHandleErrorServer<ResponseFavoritesModel>(() async {
      final response = await get('$BASE_URL/account/favorites', headers: {
        'Authorization': token ?? "",
      });
      return ResponseFavoritesModel.fromJson(response.json);
    });
  }

//=================================================================================================================================

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

//=================================================================================================================================
  Future<StoryResponseModel> getStories() async {
    return executeAndHandleErrorServer<StoryResponseModel>(() async {
      final response = await get('$BASE_URL/histories', headers: {
        'Authorization': token ?? "",
      });
      return StoryResponseModel.fromJson(response.json);
    });
  }

//=================================================================================================================================

  Future<HistoryModel> getHistories() async {
    return executeAndHandleErrorServer<HistoryModel>(() async {
      final response = await get('$BASE_URL/settings', headers: {
        'Authorization': token ?? "",
      });
      return HistoryModel.fromJson(response.json);
    });
  }

//=================================================================================================================================
  Future<HistoryModel> setHistories(String key, String value) async {
    return executeAndHandleErrorServer<HistoryModel>(() async {
      print({'key': key, 'value': value});
      final response = await put('$BASE_URL/setting', body: {
        'key': key,
        'value': value
      }, headers: {
        'Authorization': token ?? "",
      });
      return HistoryModel.fromJson(response.json);
    });
  }

//=================================================================================================================================

  Future<MaterialResponseModel> getMaterials() async {
    return executeAndHandleErrorServer<MaterialResponseModel>(() async {
      final response = await get('$BASE_URL/materials', headers: {
        'Authorization': token ?? "",
      });
      return MaterialResponseModel.fromJson(response.json);
    });
  }
}
