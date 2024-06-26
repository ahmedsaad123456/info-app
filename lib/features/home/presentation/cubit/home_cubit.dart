import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/features/home/data/models/course_model.dart';
import 'package:info_app/features/home/data/models/favorites_model.dart';
import 'package:info_app/features/home/data/models/history_model.dart';
import 'package:info_app/features/home/domain/entities/course_entity.dart';
import 'package:info_app/features/home/domain/entities/history_entity.dart';
import 'package:info_app/features/home/domain/entities/material_entity.dart';
import 'package:info_app/features/home/domain/entities/request_favorites_entity.dart';
import 'package:info_app/features/home/domain/entities/story_entity.dart';
import 'package:info_app/features/home/domain/usecases/home_usecase.dart';
import 'package:info_app/features/home/presentation/cubit/home_satate.dart';
import 'package:info_app/features/home/presentation/pages/home_page.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:info_app/features/profile/presentation/pages/profile_page.dart';
import 'package:info_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:info_app/features/search/presentation/pages/search_page.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeUsecase) : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

//================================================================================================================================

// handle bottom navigation bar

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
    return index == itemIndex ? const Color(0xFFF8206E) : Colors.white;
  }

  Color getTextColor(int itemIndex) {
    return index == itemIndex
        ? const Color(0xFFF8206E)
        : Colors.white.withOpacity(0.6399999856948853);
  }

//================================================================================================================================

// handle courses

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
        (r) async {
          courseModel = r.courses;
          await getFavorites();
          updateFavoritesInCourses();
          categorizeCourses();
          gatherCategories();
          createCategoryCourseMap();
          emit(GetCoursesSuccessState());
        },
      );
    }
  }

//================================================================================================================================

  void updateFavoritesInCourses() {
    if (responseFavoritesModel != null) {
      final favoriteCourseIds = responseFavoritesModel!.favorites?.courses
              ?.map((course) => course.id)
              .toList() ??
          [];
      for (var course in courseModel!) {
        course.isFavorite = favoriteCourseIds.contains(course.id);
      }
    }
  }

//================================================================================================================================

  ResponseFavoritesModel? responseFavoritesModel;
  RequestFavoritesEntity? requestFavoritesEntity;

  Future<void> getFavorites() async {
    if (responseFavoritesModel == null) {
      emit(GetFavoritesLoadingState());
      final result = await homeUsecase.getFavorites();
      result.fold(
        (l) {
          emit(GetFavoritesErrorState(error: l));
        },
        (r) {
          responseFavoritesModel = r;
          // Update the isFavorite attribute in the responseFavoritesModel list
          if (responseFavoritesModel?.favorites?.courses != null) {
            for (var course in responseFavoritesModel!.favorites!.courses!) {
              course.isFavorite = true; // Set isFavorite to true by default
            }
          }
          updateRequestFavoritesEntity();
          emit(GetFavoritesSuccessState());
        },
      );
    }
  }

//================================================================================================================================

  void updateRequestFavoritesEntity() {
    final favoriteCourseIds = responseFavoritesModel?.favorites?.courses
            ?.map((course) => course.id)
            .whereType<int>()
            .toList() ??
        [];
    final favoriteMaterialIds = responseFavoritesModel?.favorites?.materials
            ?.map((material) => material.id)
            .whereType<int>()
            .toList() ??
        [];

    requestFavoritesEntity = RequestFavoritesEntity(
      courses: favoriteCourseIds,
      materials: favoriteMaterialIds,
    );
  }

//================================================================================================================================

  CodeModel? codeModel;
  Future<void> setFavorites(int courseId,
      {bool isSearch = false, BuildContext? context}) async {
    emit(SetFavoritesLoadingState());

    // Toggle the favorite status locally in the main courseModel list
    final courseIndex =
        courseModel?.indexWhere((course) => course.id == courseId);
    if (courseIndex != null && courseIndex != -1) {
      courseModel![courseIndex].isFavorite =
          !courseModel![courseIndex].isFavorite!;
    }

    if (isSearch && context != null) {
      SearchCubit.get(context).updateFavoriteStatus(courseId);
    }

    // Update the requestFavoritesEntity and responseFavoritesModel
    if (requestFavoritesEntity != null) {
      if (requestFavoritesEntity!.courses!.contains(courseId)) {
        requestFavoritesEntity!.courses!.remove(courseId);
        responseFavoritesModel?.favorites?.courses
            ?.removeWhere((course) => course.id == courseId);
      } else {
        requestFavoritesEntity!.courses!.add(courseId);
        final courseToAdd =
            courseModel?.firstWhere((course) => course.id == courseId);
        if (courseToAdd != null) {
          responseFavoritesModel?.favorites?.courses?.add(courseToAdd);
        }
      }
    } else {
      requestFavoritesEntity = RequestFavoritesEntity(
        courses: [courseId],
        materials: [],
      );
    }

    final result = await homeUsecase.setFavorites(requestFavoritesEntity!);
    result.fold(
      (l) {
        emit(SetFavoritesErrorState(error: l));
      },
      (r) {
        codeModel = r;
        emit(SetFavoritesSuccessState());
      },
    );
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

//================================================================================================================================

  void gatherCategories() {
    // Ensure at least one category is selected for each type
    selectedDemoCategories =
        demoCategories.isNotEmpty ? [demoCategories.first] : [];
    selectedNeroCategories =
        neroCategories.isNotEmpty ? [neroCategories.first] : [];
    selectedNeroPlusCategories =
        neroPlusCategories.isNotEmpty ? [neroPlusCategories.first] : [];
  }

//================================================================================================================================

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

//================================================================================================================================

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

//================================================================================================================================

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

//================================================================================================================================

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

//================================================================================================================================

  void createCategoryCourseMap() {
    categoryCourseMap.clear();
    for (var course in courseModel!) {
      if (categoryCourseMap.containsKey(course.category)) {
        categoryCourseMap[course.category]!.add(course);
      } else {
        categoryCourseMap[course.category ?? ""] = [course];
      }
    }
  }

//================================================================================================================================

  List<StoryEntity>? stories;
  Future<void> getStories() async {
    if (stories == null) {
      emit(GetStoriesLoadingState());
      final result = await homeUsecase.getStories();
      result.fold(
        (l) {
          emit(GetStoriesErrorState(error: l));
        },
        (r) async {
          stories = r.histories;
          print(r);

          emit(GetStoriesSuccessState());
        },
      );
    }
  }

//================================================================================================================================

  List<MaterialEntity>? materials;

  Future<void> getMaterials() async {
    emit(GetMaterialsLoadingState());
    final result = await homeUsecase.getMaterials();
    result.fold(
      (l) {
        emit(GetMaterialsErrorState(error: l));
      },
      (r) async {
        materials = r.materials;

        emit(GetMaterialsSuccessState());
      },
    );
  }
//================================================================================================================================

  List<int>? coursesHistoryId;
  List<int>? videosHistoryId;
  List<CourseEntity>? courseHistories;
  List<MaterialEntity>? materialsHistories;

  Future<void> getHistories() async {
    emit(GetHistoriesLoadingState());
    final result = await homeUsecase.getHistories();
    result.fold(
      (l) {
        emit(GetHistoriesErrorState(error: l));
      },
      (r) async {
        await getCourses();
        await getMaterials();
        for (var setting in r.settings!) {
          if (setting.key == 'course_history') {
            coursesHistoryId = setting.value;
          } else if (setting.key == 'video_history') {
            videosHistoryId = setting.value;
          }
        }

        // Populate courseHistories
        if (coursesHistoryId != null && courseModel != null) {
          courseHistories = courseModel!
              .where((course) => coursesHistoryId!.contains(course.id))
              .toList();
        }

        // Populate materialsHistories
        if (videosHistoryId != null && materials != null) {
          materialsHistories = materials!
              .where((material) => videosHistoryId!.contains(material.id))
              .toList();
        }

        print(coursesHistoryId);
        print(videosHistoryId);
        print(courseHistories);
        print(materialsHistories);

        emit(GetHistoriesSuccessState());
      },
    );
  }

//================================================================================================================================
 Future<void> setHistories(String key, int id) async {
  emit(SetHistoriesLoadingState());

  if (key == 'courses_history') {
    coursesHistoryId ??= [];
    if (!coursesHistoryId!.contains(id)) {
      coursesHistoryId!.add(id);
      // Add the course to the courseHistories list
      final course = courseModel?.firstWhere((course) => course.id == id);
      if (course != null) {
        courseHistories ??= [];
        courseHistories!.add(course);
      }
    }
  } else if (key == 'video_history') {
    videosHistoryId ??= [];
    if (!videosHistoryId!.contains(id)) {
      videosHistoryId!.add(id);
      // Add the material to the materialsHistories list
      final material = materials?.firstWhere((material) => material.id == id);
      if (material != null) {
        materialsHistories ??= [];
        materialsHistories!.add(material);
      }
    }
  } else {
    emit(SetHistoriesErrorState(error: "Invalid key"));
    return;
  }

  print(videosHistoryId);

  // Convert the updated list to a string
  String value = key == 'courses_history'
      ? jsonEncode(coursesHistoryId)
      : jsonEncode(videosHistoryId);

  final result = await homeUsecase.setHistories(
    key,
    value,
  );
  result.fold(
    (l) {
      emit(SetHistoriesErrorState(error: l));
    },
    (r) async {
      print(r.settings?[0].value);

      emit(SetHistoriesSuccessState());
    },
  );
}

//================================================================================================================================
}
