import 'package:dartz/dartz.dart';
import 'package:info_app/features/search/data/models/search_model.dart';


abstract class SearchRepository {
  Future<Either<String, SearchModel>> search(String query);
}
