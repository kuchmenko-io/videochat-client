import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:videochat_client/core/errors/failure.dart';
import 'package:videochat_client/core/errors/server_failure.dart';
import 'package:videochat_client/core/use_cases/use_case.dart';
import 'package:videochat_client/features/authentication/domain/repositories/session_repository.dart';

class LogoutUseCase extends UseCase<void, LogoutSessionParams> {
  final SessionRepository authenticationRepository;

  LogoutUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, void>> call(LogoutSessionParams params) async {
    try {
      return Right(await this.authenticationRepository.logout());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

class LogoutSessionParams extends Equatable {
  @override
  List<Object?> get props => [];
}
