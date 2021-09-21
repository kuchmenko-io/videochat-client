import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:videochat_client/core/errors/failure.dart';
import 'package:videochat_client/core/use_cases/use_case.dart';
import 'package:videochat_client/features/authentication/domain/entities/session.dart';
import 'package:videochat_client/features/authentication/domain/entities/session_with_user.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';
import 'package:videochat_client/features/authentication/domain/repositories/session_repository.dart';
import 'package:videochat_client/features/authentication/domain/repositories/users_repository.dart';

class RestoreSessionUseCase
    extends UseCase<SessionWithUserEntity, RestoreSessionParams> {
  final SessionRepository authenticationRepository;
  final UsersRepository usersRepository;

  RestoreSessionUseCase({
    required this.authenticationRepository,
    required this.usersRepository,
  });

  Future<Either<Failure, SessionWithUserEntity>> call(
    RestoreSessionParams params,
  ) async {
    final sessionOrFailure = await authenticationRepository.restoreSession();
    final failureOrUser = await usersRepository.getUserDetails();

    return Either.map2(
      sessionOrFailure,
      failureOrUser,
      (SessionEntity session, UserEntity user) =>
          SessionWithUserEntity.fromSession(
        session: session,
        user: user,
      ),
    );
  }
}

class RestoreSessionParams extends Equatable {
  @override
  List<Object?> get props => [];
}
