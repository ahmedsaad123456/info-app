import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/features/courses/presentation/cubit/course_cubit.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:info_app/features/login_screen/presentation/cubit/auth_cubit.dart';
import 'package:info_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:info_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:info_app/locator.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  BlocProvider(create: (_) => locator<AuthCubit>()),
  BlocProvider(create: (_) => locator<HomeCubit>()),
  BlocProvider(create: (_) => locator<ProfileCubit>()),
  BlocProvider(create: (_) => locator<SearchCubit>()),
  BlocProvider(create: (_) => locator<CourseCubit>()),
];
