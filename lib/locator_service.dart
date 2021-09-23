import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:videochat_client/features/authentication/data/datasources/session_local_datasource.dart';
import 'package:videochat_client/features/authentication/data/datasources/session_remote_datasource.dart';
import 'package:videochat_client/features/authentication/data/datasources/user_remote_datasource.dart';
import 'package:videochat_client/features/authentication/data/repositories/session_repository_impl.dart';
import 'package:videochat_client/features/authentication/data/repositories/users_repository_impl.dart';
import 'package:videochat_client/features/authentication/domain/repositories/session_repository.dart';
import 'package:videochat_client/features/authentication/domain/repositories/users_repository.dart';
import 'package:videochat_client/features/authentication/domain/use_cases/restore_session.dart';
import 'package:videochat_client/features/authentication/domain/use_cases/sign_in.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/restore_session_bloc/restore_session_bloc.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_cubit.dart';

import 'features/authentication/domain/use_cases/logout_use_case.dart';

final sl = GetIt.instance;

init() {
  // BLoC / Cubit
  sl.registerFactory(() => RestoreSessionBloc(restoreSession: sl()));
  sl.registerLazySingleton(
    () => SessionCubit(
      restoreSessionUseCase: sl(),
      signInUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(
    () => RestoreSessionUseCase(
      authenticationRepository: sl(),
      usersRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignInUseCase(
      authenticationRepository: sl(),
      usersRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LogoutUseCase(
      authenticationRepository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl(),
    ),
  );
  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(
      sessionLocalDatasource: sl(),
      userRemoteDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<SessionLocalDatasource>(
    () => SessionLocalDatasourceImpl(
      storage: sl(),
    ),
  );
  sl.registerLazySingleton<SessionRemoteDatasource>(
    () => SessionRemoteDatasourceImpl(
      appAuth: sl(),
    ),
  );

  sl.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(client: sl()));

  // Core

  // External
  sl.registerLazySingleton<Client>(
    () => Client(),
  );

  sl.registerLazySingleton<FlutterAppAuth>(
    () => FlutterAppAuth(),
  );

  sl.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );
}
