import 'package:dartz/dartz.dart';
import 'package:info_app/core/error/execute_and_handle_error.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/features/login_screen/data/datasources/api_service_auth.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/login_screen/data/models/user_model.dart';
import 'package:info_app/features/login_screen/domain/repositories/auth_repository.dart';
import 'package:info_app/features/search/data/datasources/api_service_search.dart';
import 'package:info_app/features/search/data/models/search_model.dart';
import 'package:info_app/features/search/domain/repositories/search_repository.dart';

class SearchImplRepository implements SearchRepository {
  ApiServiceSearch apiServiceSeach;
  SearchImplRepository(this.apiServiceSeach);

  @override
  Future<Either<String, SearchModel>> search(String query) {
    return executeAndHandleError<SearchModel>(() async {
      final res = await apiServiceSeach.search(query);
      return res;
    });
  }
}
