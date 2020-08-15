import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:military_hub/features/social/data/datasources/database/user_db_repository.dart';
import 'package:military_hub/features/social/data/datasources/janus/janus_webrtc_repository.dart';
import 'package:military_hub/features/social/data/datasources/msengine/msengine_feeds_repository.dart';
import 'package:military_hub/features/social/data/datasources/msengine/msengine_user_repository.dart';
import 'package:military_hub/features/social/data/repositories/feeds_repository_impl.dart';
import 'package:military_hub/features/social/data/repositories/user_repository_impl.dart';
import 'package:military_hub/features/social/data/repositories/webrtc_repository_impl.dart';
import 'package:military_hub/features/social/domain/repositories/feeds_repository.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:military_hub/features/social/domain/repositories/webrtc_repository.dart';
import 'package:military_hub/features/social/domain/usecase/feeds_usecase.dart';
import 'package:military_hub/features/social/domain/usecase/user_usecase.dart';
import 'package:military_hub/features/social/domain/usecase/webrtc_usecase.dart';
import 'package:military_hub/features/social/presentation/bloc/fetch/feeds/bloc.dart';
import 'package:military_hub/features/social/presentation/bloc/fetch/user/bloc.dart';
import 'package:military_hub/features/social/presentation/bloc/fetch/webrtc/bloc.dart';
import 'package:military_hub/features/social/presentation/bloc/transaction/webrtc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => GetUserInfoBloc(userUseCase: sl()));
  sl.registerFactory(() => GetNearUserListBloc(userUseCase: sl()));
  sl.registerFactory(() => GetUserListByEmailsBloc(userUseCase: sl()));
  sl.registerFactory(() => GetFeedsBloc(feedsUseCase: sl()));
  sl.registerFactory(() => CreateWebRTCTransactionBloc(webRTCUseCase: sl()));
  sl.registerFactory(() => GetLiveBroadcasterListBloc(webRTCUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => UserUseCase(sl()));
  sl.registerLazySingleton(() => WebRTCUseCase(sl()));
  sl.registerLazySingleton(() => FeedsUseCase(sl()));

  // Data sources
  // Db repository
  sl.registerLazySingleton(() => UserDbRepository());
  // MSEngine repository
  sl.registerLazySingleton(() => MSEngineUserRepository());
  sl.registerLazySingleton(() => MSEngineFeedsRepository());
  sl.registerLazySingleton(() => JanusWebRTCRepository());

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        userDbRepository: sl(), msEngineUserRepository: sl()),
  );
  sl.registerLazySingleton<FeedsRepository>(
    () => FeedsRepositoryImpl(msEngineFeedsRepository: sl()),
  );
  sl.registerLazySingleton<WebRTCRepository>(
    () => WebRTCRepositoryImpl(janusWebRTCRepository: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
