import 'package:dartz/dartz.dart';

import 'package:info_app/features/search/data/models/search_model.dart';
import 'package:info_app/features/search/domain/repositories/search_repository.dart';

class SearchUsecasae {
  final SearchRepository searchRepository;

  SearchUsecasae(this.searchRepository);

  Future<Either<String, SearchModel>> search(String query) async {
    return await searchRepository.search(query);
  }
}
