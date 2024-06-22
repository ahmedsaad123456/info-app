import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:info_app/features/login_screen/presentation/cubit/auth_cubit.dart';
import 'package:info_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:info_app/locator.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
    BlocProvider(create: (_) => locator<AuthCubit>()),
    BlocProvider(create: (_) => locator<HomeCubit>()),
    BlocProvider(create: (_) => locator<ProfileCubit>()),

  // BlocProvider(create: (_) => locator<HomeCubit>()),
  // BlocProvider(create: (_) => locator<SplashCubit>()),
  // BlocProvider(create: (_) => locator<AuthBloc>()),
  // BlocProvider(create: (_) => locator<CountryCubit>()),
  // BlocProvider(create: (_) => locator<ThemeModeCubit>()),
  // BlocProvider(create: (_) => locator<MainCubit>()),
  // BlocProvider(create: (_) => locator<ProfileCubit>()),
];
