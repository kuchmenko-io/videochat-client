import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videochat_client/core/errors/cache_failure.dart';
import 'package:videochat_client/core/errors/failure.dart';
import 'package:videochat_client/core/errors/server_failure.dart';
import 'package:videochat_client/features/authentication/domain/use_cases/restore_session.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/restore_session_bloc/restore_session_event.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/restore_session_bloc/restore_session_state.dart';

class RestoreSessionBloc
    extends Bloc<RestoreSessionEvent, RestoreSessionState> {
  final RestoreSessionUseCase restoreSession;

  RestoreSessionBloc({required this.restoreSession})
      : super(RestoreSessionEmpty());

  @override
  Stream<RestoreSessionState> mapEventToState(
      RestoreSessionEvent event) async* {
    if (event is RestoreSessionEvent) {
      yield* _mapRestoreSessionToState(event);
    }
  }

  Stream<RestoreSessionState> _mapRestoreSessionToState(
      RestoreSessionEvent event) async* {
    yield RestoreSessionLoading();

    final failureOrSession = await restoreSession(RestoreSessionParams());

    yield failureOrSession.fold(
      (failure) => RestoreSessionFailed(message: _mapFailureToMessage(failure)),
      (session) => RestoreSessionLoaded(session: session),
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
