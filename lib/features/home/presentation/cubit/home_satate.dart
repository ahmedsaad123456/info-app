abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeBottomNavState extends HomeStates {}

class GetCoursesLoadingState extends HomeStates {}

class GetCoursesErrorState extends HomeStates {
  final String error;
  GetCoursesErrorState({required this.error});
}

class GetCoursesSuccessState extends HomeStates {}

class GetFavoritesLoadingState extends HomeStates {}

class GetFavoritesErrorState extends HomeStates {
  final String error;
  GetFavoritesErrorState({required this.error});
}

class GetFavoritesSuccessState extends HomeStates {}

class SetFavoritesLoadingState extends HomeStates {}

class SetFavoritesErrorState extends HomeStates {
  final String error;
  SetFavoritesErrorState({required this.error});
}

class SetFavoritesSuccessState extends HomeStates {}

class GetStoriesLoadingState extends HomeStates {}

class GetStoriesErrorState extends HomeStates {
  final String error;
  GetStoriesErrorState({required this.error});
}

class GetStoriesSuccessState extends HomeStates {}

class GetHistoriesLoadingState extends HomeStates {}

class GetHistoriesErrorState extends HomeStates {
  final String error;
  GetHistoriesErrorState({required this.error});
}

class GetHistoriesSuccessState extends HomeStates {}

class SetHistoriesLoadingState extends HomeStates {}

class SetHistoriesErrorState extends HomeStates {
  final String error;
  SetHistoriesErrorState({required this.error});
}

class SetHistoriesSuccessState extends HomeStates {}


class GetMaterialsLoadingState extends HomeStates {}

class GetMaterialsErrorState extends HomeStates {
  final String error;
  GetMaterialsErrorState({required this.error});
}

class GetMaterialsSuccessState extends HomeStates {}
