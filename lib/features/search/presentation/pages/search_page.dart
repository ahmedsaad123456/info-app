import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/features/search/data/models/search_model.dart';
import 'package:info_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:info_app/features/search/presentation/cubit/search_state.dart';
import 'package:info_app/features/search/presentation/widgets/course_saerch.dart';
import 'package:info_app/features/search/presentation/widgets/search_input.dart';
import 'package:info_app/features/search/presentation/widgets/video_search.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        SearchModel? searchModel = SearchCubit.get(context).searchModel;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Поиск',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SearchInput(),
            ),
            const SizedBox(
              height: 32,
            ),
            if (searchModel?.materials?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: VideoSearch(
                  materials: searchModel?.materials ?? [],
                ),
              ),
            const SizedBox(
              height: 32,
            ),
            if (searchModel?.courses?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CourseSaerch(
                  courses: searchModel?.courses ?? [],
                ),
              ),
          ],
        );
      },
    );
  }
}
