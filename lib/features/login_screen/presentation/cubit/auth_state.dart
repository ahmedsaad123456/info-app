
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState({required this.error});
}

class AuthSuccessState extends AuthState {}

class ChangeFormState extends AuthState {}


class CodeLoadingState extends AuthState {}

class CodeErrorState extends AuthState {
  final String error;
  CodeErrorState({required this.error});
}

class CodeSuccessState extends AuthState {}