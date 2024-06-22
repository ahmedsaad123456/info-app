abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeBottomNavState extends HomeStates {}


class GetCoursesLoadingState extends HomeStates {}

class GetCoursesErrorState extends HomeStates {
  final String error;
  GetCoursesErrorState({required this.error});
}

class GetCoursesSuccessState extends HomeStates {}