import 'package:get_it/get_it.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/core/shared/usecases/network_info.dart';
import 'package:info_app/features/courses/data/datasources/api_service_course.dart';
import 'package:info_app/features/courses/data/repositories/course_impl_repository.dart';
import 'package:info_app/features/courses/domain/repositories/course_repository.dart';
import 'package:info_app/features/courses/domain/usecases/course_usecase.dart';
import 'package:info_app/features/courses/presentation/cubit/course_cubit.dart';
import 'package:info_app/features/home/data/datasources/api_service_home.dart';
import 'package:info_app/features/home/data/repositories/home_impl_repository.dart';
import 'package:info_app/features/home/domain/repositories/home_repository.dart';
import 'package:info_app/features/home/domain/usecases/home_usecase.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:info_app/features/login_screen/data/datasources/api_service_auth.dart';
import 'package:info_app/features/login_screen/data/repositories/auth_impl_repositories.dart';
import 'package:info_app/features/login_screen/domain/repositories/auth_repository.dart';
import 'package:info_app/features/login_screen/domain/usecases/auth_usecase.dart';
import 'package:info_app/features/login_screen/presentation/cubit/auth_cubit.dart';
import 'package:info_app/features/profile/data/datasources/api_service_profile.dart';
import 'package:info_app/features/profile/data/repositories/profile_impl_repository.dart';
import 'package:info_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:info_app/features/profile/domain/usecases/profile_usecase.dart';
import 'package:info_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:info_app/features/search/data/datasources/api_service_search.dart';
import 'package:info_app/features/search/data/repositories/search_impl_repository.dart';
import 'package:info_app/features/search/domain/repositories/search_repository.dart';
import 'package:info_app/features/search/domain/usecases/search_usecasae.dart';
import 'package:info_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //BLOC
  locator.registerFactory(() => AuthCubit(locator()));
  locator.registerFactory(() => HomeCubit(locator())..getCourses());
  locator.registerFactory(() => ProfileCubit(locator()));
  locator.registerFactory(() => SearchCubit(locator()));
  locator.registerLazySingleton(() => CourseCubit(locator()));

  // //USECASES
  locator.registerLazySingleton(() => AuthUseCase(locator()));
  locator.registerLazySingleton(() => ProfileUsecase(locator()));
  locator.registerLazySingleton(() => HomeUsecase(locator()));
  locator.registerLazySingleton(() => SearchUsecasae(locator()));
  locator.registerLazySingleton(() => CourseUseCase(locator()));
  // //CORE
  // locator.registerLazySingleton(() => NetworkInfoImpl(locator()));

  // //REPOSITORISE
  locator.registerLazySingleton<AuthRepository>(
      () => AuthImplRepository(locator()));

  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileImplRepository(locator()),
  );
  locator.registerLazySingleton<CourseRepository>(
      () => CourseImplRepository(locator()));

  locator.registerLazySingleton<HomeRepository>(
    () => HomeImplRepository(locator()),
  );

  locator.registerLazySingleton<SearchRepository>(
    () => SearchImplRepository(locator()),
  );
  // //DATASOURSE
  locator.registerLazySingleton(() => ApiServiceAuth());
  locator.registerLazySingleton(
    () => ApiserviceProfile(),
  );
  locator.registerLazySingleton(() => ApiServiceHome());
  locator.registerLazySingleton(() => ApiServiceSearch());
  locator.registerLazySingleton(() => ApiServiceCourse());

  // //EXTRNAL
  locator.registerLazySingleton(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => InternetConnectionChecker());

  locator.registerLazySingleton(() => NetworkChecker(locator()));
  locator.registerLazySingleton(() => CacheHelper());
}
