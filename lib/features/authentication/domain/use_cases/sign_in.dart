import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:videochat_client/core/errors/failure.dart';
import 'package:videochat_client/core/use_cases/use_case.dart';
import 'package:videochat_client/features/authentication/domain/entities/session.dart';
import 'package:videochat_client/features/authentication/domain/entities/session_with_user.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';
import 'package:videochat_client/features/authentication/domain/repositories/session_repository.dart';
import 'package:videochat_client/features/authentication/domain/repositories/users_repository.dart';

class SignInUseCase extends UseCase<SessionWithUserEntity, SignInParams> {
  final SessionRepository authenticationRepository;
  final UsersRepository usersRepository;

  SignInUseCase({
    required this.authenticationRepository,
    required this.usersRepository,
  });

  Future<Either<Failure, SessionWithUserEntity>> call(
    SignInParams params,
  ) async {
    final failureOrSession = await authenticationRepository.signIn();
    final failureOrUser = await usersRepository.getUserDetails();

    return Either.map2(
      failureOrSession,
      failureOrUser,
      (SessionEntity session, UserEntity user) =>
          SessionWithUserEntity.fromSession(
        session: session,
        user: user,
      ),
    );
  }
}

class SignInParams extends Equatable {
  @override
  List<Object?> get props => [];
}
