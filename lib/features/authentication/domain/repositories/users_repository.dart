import 'package:dartz/dartz.dart';
import 'package:videochat_client/core/errors/server_failure.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';

abstract class UsersRepository {
  Future<Either<ServerFailure, UserEntity>> getUserDetails();
}
