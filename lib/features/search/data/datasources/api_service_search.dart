import 'package:info_app/core/constants.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/remote/api_base.dart';

import 'package:info_app/features/search/data/models/search_model.dart';

class ApiServiceSearch extends ApiBase {
  Future<SearchModel> search(String query) async {
    return executeAndHandleErrorServer<SearchModel>(() async {
      final response =
          await get('$BASE_URL/search/$query?', queryParameters: {
        'quantity': '10',
        'skip': '0',
      });
      return SearchModel.fromJson(response.json);
    });
  }
}
