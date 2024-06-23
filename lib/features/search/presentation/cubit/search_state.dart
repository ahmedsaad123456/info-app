
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String error;
  SearchErrorState({required this.error});
}

class SearchSuccessState extends SearchState {}
