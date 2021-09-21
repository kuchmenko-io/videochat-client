import 'package:dartz/dartz.dart';
import 'package:videochat_client/core/errors/failure.dart';
import 'package:videochat_client/core/errors/server_failure.dart';
import 'package:videochat_client/features/authentication/data/datasources/session_local_datasource.dart';
import 'package:videochat_client/features/authentication/data/datasources/session_remote_datasource.dart';
import 'package:videochat_client/features/authentication/domain/entities/session.dart';
import 'package:videochat_client/features/authentication/domain/repositories/session_repository.dart';

class SessionRepositoryImpl extends SessionRepository {
  final SessionLocalDatasource localDatasource;
  final SessionRemoteDatasource remoteDatasource;

  SessionRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, SessionEntity>> restoreSession() async {
    try {
      final localSession = await localDatasource.getSession();
      final session =
          await remoteDatasource.restoreSession(localSession.refreshToken);
      await localDatasource.setSession(session);

      return Right(session);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SessionEntity>> signIn() async {
    try {
      await localDatasource.clearSession();
      final session = await remoteDatasource.createSession();
      await localDatasource.setSession(session);

      return Right(session);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
