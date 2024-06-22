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
        ? Color(0xFFF8206E)
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
  Map<String, List<CourseEntity>> categoryCourseMap = {};

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
          createCategoryCourseMap();
          emit(GetCoursesSuccessState());
        },
      );
    }
  }

  List<String> selectedDemoCategories = [];
  List<String> selectedNeroCategories = [];
  List<String> selectedNeroPlusCategories = [];

  void categorizeCourses() {
    demoCategories = courseModel
            ?.where((course) => course.type == 'demo')
            .map((course) => course.category!)
            .toSet()
            .toList() ??
        [];
    neroCategories = courseModel
            ?.where((course) => course.type == 'nero')
            .map((course) => course.category!)
            .toSet()
            .toList() ??
        [];
    neroPlusCategories = courseModel
            ?.where((course) => course.type == 'nero_plus')
            .map((course) => course.category!)
            .toSet()
            .toList() ??
        [];

    demoCourses = courseModel
            ?.where((course) =>
                course.type == 'demo' &&
                course.category == demoCategories.first)
            .toList() ??
        [];
    neroCourses = courseModel
            ?.where((course) =>
                course.type == 'nero' &&
                course.category == neroCategories.first)
            .toList() ??
        [];
    neroPlusCourses = courseModel
            ?.where((course) =>
                course.type == 'nero_plus' &&
                course.category == neroPlusCategories.first)
            .toList() ??
        [];
  }

  void gatherCategories() {
    // Ensure at least one category is selected for each type
    selectedDemoCategories =
        demoCategories.isNotEmpty ? [demoCategories.first] : [];
    selectedNeroCategories =
        neroCategories.isNotEmpty ? [neroCategories.first] : [];
    selectedNeroPlusCategories =
        neroPlusCategories.isNotEmpty ? [neroPlusCategories.first] : [];
  }

  bool toggleCategory(String category, int type) {
    if (type == 1) {
      if (selectedDemoCategories.contains(category)) {
        if (selectedDemoCategories.length > 1) {
          selectedDemoCategories.remove(category);
          getFilteredDemoCourses();
          emit(GetCoursesSuccessState());
          return true;
        } else {
          return false;
        }
      } else {
        selectedDemoCategories.add(category); // Allow multiple selections
        getFilteredDemoCourses();
        emit(GetCoursesSuccessState());
        return true;
      }
    } else if (type == 2) {
      if (selectedNeroCategories.contains(category)) {
        if (selectedNeroCategories.length > 1) {
          selectedNeroCategories.remove(category);
          getFilteredNeroCourses();
          emit(GetCoursesSuccessState());
          return true;
        } else {
          // Can't remove the last category
          return false;
        }
      } else {
        selectedNeroCategories.add(category); // Allow multiple selections
        getFilteredNeroCourses();
        emit(GetCoursesSuccessState());
        return true;
      }
    } else if (type == 3) {
      if (selectedNeroPlusCategories.contains(category)) {
        if (selectedNeroPlusCategories.length > 1) {
          selectedNeroPlusCategories.remove(category);
          getFilteredNeroPlusCourses();
          emit(GetCoursesSuccessState());
          return true;
        } else {
          // Can't remove the last category
          return false;
        }
      } else {
        selectedNeroPlusCategories.add(category); // Allow multiple selections
        getFilteredNeroPlusCourses();
        emit(GetCoursesSuccessState());
        return true;
      }
    }
    return false;
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
    if (selectedNeroCategories.isNotEmpty) {
      neroCourses = courseModel!
          .where((course) => course.type == 'nero')
          .where((course) => selectedNeroCategories.contains(course.category))
          .toList();
    } else {
      neroCourses =
          courseModel?.where((course) => course.type == 'nero').toList() ?? [];
    }
  }

  void getFilteredNeroPlusCourses() {
    if (selectedNeroPlusCategories.isNotEmpty) {
      neroPlusCourses = courseModel!
          .where((course) => course.type == 'nero_plus')
          .where(
              (course) => selectedNeroPlusCategories.contains(course.category))
          .toList();
    } else {
      neroPlusCourses =
          courseModel?.where((course) => course.type == 'nero_plus').toList() ??
              [];
    }
  }

  void createCategoryCourseMap() {
    categoryCourseMap.clear();
    for (var course in courseModel!) {
      if (categoryCourseMap.containsKey(course.category)) {
        categoryCourseMap[course.category]!.add(course);
      } else {
        categoryCourseMap[course.category!] = [course];
      }
    }
  }
}
