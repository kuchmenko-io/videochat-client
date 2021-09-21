import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:videochat_client/core/errors/server_failure.dart';
import 'package:videochat_client/features/authentication/data/datasources/session_local_datasource.dart';
import 'package:videochat_client/features/authentication/data/datasources/user_remote_datasource.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';
import 'package:videochat_client/features/authentication/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final SessionLocalDatasource sessionLocalDatasource;
  final UserRemoteDatasource userRemoteDatasource;

  UsersRepositoryImpl({
    required this.sessionLocalDatasource,
    required this.userRemoteDatasource,
  });

  @override
  Future<Either<ServerFailure, UserEntity>> getUserDetails() async {
    try {
      final session = await sessionLocalDatasource.getSession();

      return Right(
        await userRemoteDatasource.getCurrentUser(session.accessToken),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
