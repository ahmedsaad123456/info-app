import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/features/courses/data/models/course_view_model.dart';
import 'package:info_app/features/courses/domain/usecases/course_usecase.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit(this.courseUseCase) : super(CourseInitial());
  static CourseCubit get(context) => BlocProvider.of(context);
  CourseUseCase courseUseCase;
  void getCourse(int id) async {
    emit(CourseLoading());
    final result = await courseUseCase.getCourses(id);
    result.fold((l) => emit(CourseError(l)), (r) => emit(CourseLoaded(r)));
  }
}
