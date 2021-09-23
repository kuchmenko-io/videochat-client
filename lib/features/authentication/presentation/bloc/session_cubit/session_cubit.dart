import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videochat_client/core/errors/cache_failure.dart';
import 'package:videochat_client/core/errors/failure.dart';
import 'package:videochat_client/core/errors/server_failure.dart';
import 'package:videochat_client/features/authentication/domain/use_cases/logout_use_case.dart';
import 'package:videochat_client/features/authentication/domain/use_cases/restore_session.dart';
import 'package:videochat_client/features/authentication/domain/use_cases/sign_in.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final RestoreSessionUseCase restoreSessionUseCase;
  final SignInUseCase signInUseCase;
  final LogoutUseCase logoutUseCase;

  SessionCubit({
    required this.restoreSessionUseCase,
    required this.signInUseCase,
    required this.logoutUseCase,
  }) : super(SessionStateEmpty());

  Future<void> restoreSession() async {
    print('restoreSession $state');
    if (state is SessionStateLoading || state is SessionStateLoaded) return;

    emit(SessionStateLoading(isRestoringSession: true));

    final failureOrSession =
        await restoreSessionUseCase(RestoreSessionParams());
    print('restoreSession $state');

    failureOrSession.fold(
      (failure) {
        print('Restore Failure $failure');
        emit(SessionStateFailure(message: _mapFailureToMessage(failure)));
      },
      (session) {
        print('Restore Success $session');
        emit(SessionStateLoaded(session: session));
      },
    );
  }

  Future<void> signIn() async {
    print('signIn $state');
    if (state is SessionStateLoading || state is SessionStateLoaded) return;

    emit(SessionStateLoading(isRestoringSession: false));

    final failureOrSession = await signInUseCase(SignInParams());

    failureOrSession.fold(
      (failure) =>
          emit(SessionStateFailure(message: _mapFailureToMessage(failure))),
      (session) => emit(SessionStateLoaded(session: session)),
    );
  }

  Future<void> logout() async {
    print(state);
    print(state.runtimeType);
    if (!(state is SessionStateLoaded)) return;

    final failureOrSession = await logoutUseCase(LogoutSessionParams());

    failureOrSession.fold(
      (failure) {
        print('logout failure $failure');
        emit(SessionStateFailure(message: _mapFailureToMessage(failure)));
      },
      (session) {
        print('logout success');
        emit(SessionStateEmpty());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected error';
    }
  }
}
