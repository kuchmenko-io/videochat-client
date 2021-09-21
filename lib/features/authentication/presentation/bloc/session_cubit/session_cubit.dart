import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videochat_client/core/errors/cache_failure.dart';
import 'package:videochat_client/core/errors/failure.dart';
import 'package:videochat_client/core/errors/server_failure.dart';
import 'package:videochat_client/features/authentication/domain/use_cases/restore_session.dart';
import 'package:videochat_client/features/authentication/domain/use_cases/sign_in.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final RestoreSessionUseCase restoreSessionUseCase;
  final SignInUseCase signInUseCase;

  SessionCubit({
    required this.restoreSessionUseCase,
    required this.signInUseCase,
  }) : super(SessionStateEmpty());

  Future<void> restoreSession() async {
    if (state is SessionStateLoading || state is SessionStateLoading) return;

    emit(SessionStateLoading(isRestoringSession: true));

    final failureOrSession =
        await restoreSessionUseCase(RestoreSessionParams());

    failureOrSession.fold(
      (failure) =>
          emit(SessionStateFailure(message: _mapFailureToMessage(failure))),
      (session) => emit(SessionStateLoaded(session: session)),
    );
  }

  Future<void> signIn() async {
    if (state is SessionStateLoading || state is SessionStateLoading) return;

    emit(SessionStateLoading(isRestoringSession: false));

    final failureOrSession = await signInUseCase(SignInParams());

    failureOrSession.fold(
      (failure) =>
          emit(SessionStateFailure(message: _mapFailureToMessage(failure))),
      (session) => emit(SessionStateLoaded(session: session)),
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
