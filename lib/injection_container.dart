import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:military_hub/features/social/data/datasources/msengine/msengine_user_repository.dart';
import 'package:military_hub/features/social/data/repositories/user_repository_impl.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:military_hub/features/social/domain/usecase/user_usecase.dart';
import 'package:military_hub/features/social/presentation/bloc/fetch/user/user_block.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => GetUserInfoBloc(userUseCase: sl()));
  sl.registerFactory(() => GetUserListByEmailsBloc(userUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => UserUseCase(sl()));

  // Data sources
  // MSEngine repository
  sl.registerLazySingleton(() => MSEngineUserRepository());

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(msEngineUserRepository: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
