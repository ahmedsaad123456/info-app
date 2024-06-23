part of 'course_cubit.dart';

sealed class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

final class CourseInitial extends CourseState {}

final class CourseLoading extends CourseState {}

final class CourseError extends CourseState {
  final String message;
  const CourseError(this.message);
}

final class CourseLoaded extends CourseState {
  final CourseViewModel courseResponseModel;
  const CourseLoaded(this.courseResponseModel);
}
