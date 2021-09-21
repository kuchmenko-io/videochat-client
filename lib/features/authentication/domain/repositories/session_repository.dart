import 'package:dartz/dartz.dart';
import 'package:videochat_client/core/errors/failure.dart';
import 'package:videochat_client/features/authentication/domain/entities/session.dart';

abstract class SessionRepository {
  Future<Either<Failure, SessionEntity>> signIn();
  Future<Either<Failure, SessionEntity>> restoreSession();
}
