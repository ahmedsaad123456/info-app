
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileUpdateLoadingState extends ProfileState {}

class ProfileUpdateErrorState extends ProfileState {
  final String error;
  ProfileUpdateErrorState({required this.error});
}

class ProfileUpdateSuccessState extends ProfileState {}

