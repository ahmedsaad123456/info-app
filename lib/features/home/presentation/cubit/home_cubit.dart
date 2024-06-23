import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';
import 'package:info_app/features/home/domain/usecases/home_usecase.dart';
import 'package:info_app/features/home/presentation/cubit/home_satate.dart';
import 'package:info_app/features/home/presentation/pages/home_page.dart';
import 'package:info_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:info_app/features/profile/presentation/pages/profile_page.dart';
import 'package:info_app/features/search/search_page.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeUsecase) : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const SearchPage(),
    const HomePage(),
    ProfilePage(),
  ];

  int index = 1;

  void changeIndex(int newIndex, BuildContext context) async {
    index = newIndex;
    if (index == 2) {
      await ProfileCubit.get(context).getCodeModel();
    }
    emit(HomeBottomNavState());
  }

  Color getIconColor(int itemIndex) {
    return index == itemIndex
        ? const Color(0xFFF8206E)
        : Colors.white.withOpacity(0.64);
  }

  final HomeUsecase homeUsecase;
  List<CourseEntity>? courseModel;
  List<CourseEntity> demoCourses = [];
  List<CourseEntity> neroCourses = [];
  List<CourseEntity> neroPlusCourses = [];
  List<String> demoCategories = [];
  List<String> neroCategories = [];
  List<String> neroPlusCategories = [];

  Future<void> getCourses() async {
    if (courseModel == null) {
      emit(GetCoursesLoadingState());
      final result = await homeUsecase.getCourses();
      result.fold(
        (l) {
          emit(GetCoursesErrorState(error: l));
        },
        (r) {
          courseModel = r.courses;
          categorizeCourses();
          gatherCategories();
          emit(GetCoursesSuccessState());
        },
      );
    }
  }

  void categorizeCourses() {
    demoCourses =
        courseModel?.where((course) => course.type == 'demo').toList() ?? [];
    neroCourses =
        courseModel?.where((course) => course.type == 'nero').toList() ?? [];
    neroPlusCourses =
        courseModel?.where((course) => course.type == 'nero_plus').toList() ??
            [];
  }

  void gatherCategories() {
    demoCategories =
        demoCourses.map((course) => course.category!).toSet().toList();
    neroCategories =
        neroCourses.map((course) => course.category!).toSet().toList();
    neroPlusCategories =
        neroPlusCourses.map((course) => course.category!).toSet().toList();
  }

  List<String> selectedDemoCategories = [];
  List<String> selectedPurCategories = [];
  List<String> selectedNotPurCategories = [];

  void toggleCategory(String category, int type) {
    if (type == 1) {
      if (selectedDemoCategories.contains(category)) {
        selectedDemoCategories.remove(category);
      } else {
        selectedDemoCategories.add(category);
      }
      getFilteredDemoCourses();
      emit(GetCoursesSuccessState());
    } else if (type == 2) {
      if (selectedPurCategories.contains(category)) {
        selectedPurCategories.remove(category);
      } else {
        selectedPurCategories.add(category);
      }
      getFilteredNeroCourses();
      emit(GetCoursesSuccessState());
    } else if (type == 3) {
      if (selectedNotPurCategories.contains(category)) {
        selectedNotPurCategories.remove(category);
      } else {
        selectedNotPurCategories.add(category);
      }
      getFilteredNeroPlusCourses();
      emit(GetCoursesSuccessState());
    }
  }

  void getFilteredDemoCourses() {
    if (selectedDemoCategories.isNotEmpty) {
      demoCourses = courseModel!
          .where((course) => course.type == 'demo')
          .where((course) => selectedDemoCategories.contains(course.category))
          .toList();
    } else {
      demoCourses =
          courseModel?.where((course) => course.type == 'demo').toList() ?? [];
    }
  }

  void getFilteredNeroCourses() {
    if (selectedPurCategories.isNotEmpty) {
      neroCourses = courseModel!
          .where((course) => course.type == 'nero')
          .where((course) => selectedPurCategories.contains(course.category))
          .toList();
    } else {
      neroCourses =
          courseModel?.where((course) => course.type == 'nero').toList() ?? [];
    }
  }

  void getFilteredNeroPlusCourses() {
    if (selectedNotPurCategories.isNotEmpty) {
      neroPlusCourses = courseModel!
          .where((course) => course.type == 'nero_plus')
          .where((course) => selectedNotPurCategories.contains(course.category))
          .toList();
    } else {
      neroPlusCourses =
          courseModel?.where((course) => course.type == 'nero_plus').toList() ??
              [];
    }
  }
}
