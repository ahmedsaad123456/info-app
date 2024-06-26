import 'package:get_it/get_it.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/core/shared/usecases/network_info.dart';
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
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //BLOC
  locator.registerFactory(() => AuthCubit(locator()));
  locator.registerFactory(() => HomeCubit(locator()));
  locator.registerFactory(() => ProfileCubit(locator()));

  // //USECASES
  locator.registerLazySingleton(() => AuthUseCase(locator()));
  locator.registerLazySingleton(() => ProfileUsecase(locator()));
  locator.registerLazySingleton(() => HomeUsecase(locator()));

  // //CORE
  // locator.registerLazySingleton(() => NetworkInfoImpl(locator()));

  // //REPOSITORISE
  locator.registerLazySingleton<AuthRepository>(
      () => AuthImplRepository(locator()));

  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileImplRepository(locator()),
  );

    locator.registerLazySingleton<HomeRepository>(
    () => HomeImplRepository(locator()),
  );
  // //DATASOURSE
  locator.registerLazySingleton(() => ApiServiceAuth());
  locator.registerLazySingleton(
    () => ApiserviceProfile(),
  );
    locator.registerLazySingleton(() => ApiServiceHome());


  // //EXTRNAL
  locator.registerLazySingleton(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => InternetConnectionChecker());

  locator.registerLazySingleton(() => NetworkChecker(locator()));
  locator.registerLazySingleton(() => CacheHelper());
}
