import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:info_app/features/search/data/models/search_model.dart';
import 'package:info_app/features/search/domain/usecases/search_usecasae.dart';
import 'package:info_app/features/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchUsecasae) : super(SearchInitialState());

  TextEditingController controller = TextEditingController();

  static SearchCubit get(context) => BlocProvider.of(context);

  final SearchUsecasae searchUsecasae;

  SearchModel? searchModel;

  Timer? _debounce;
  final int _debouncetime = 700;

  Future<void> search(BuildContext context, String query) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debouncetime), () async {
      emit(SearchLoadingState());

      final result = await searchUsecasae.search(controller.text);
      result.fold(
        (l) {
          emit(SearchErrorState(error: l));
        },
        (r) {
          searchModel = r;
          updateSearchResultsWithFavorites(context);
          emit(SearchSuccessState());
        },
      );
    });
  }

  void updateSearchResultsWithFavorites(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    if (homeCubit.responseFavoritesModel != null) {
      final favoriteCourseIds = homeCubit
              .responseFavoritesModel!.favorites?.courses
              ?.map((course) => course.id)
              .toList() ??
          [];
      for (var course in searchModel?.courses ?? []) {
        course.isFavorite = favoriteCourseIds.contains(course.id);
      }
    }
  }

  void updateFavoriteStatus(int courseId) {
    if (searchModel != null) {
      final courseIndex =
          searchModel?.courses?.indexWhere((course) => course.id == courseId) ??
              -1;
      if (courseIndex != -1) {
        searchModel?.courses?[courseIndex].isFavorite =
            !(searchModel?.courses![courseIndex].isFavorite ?? true);
        emit(SearchSuccessState());
      }
    }
  }
}
