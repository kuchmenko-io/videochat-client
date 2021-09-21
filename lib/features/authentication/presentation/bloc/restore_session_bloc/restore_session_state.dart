import 'package:equatable/equatable.dart';
import 'package:videochat_client/features/authentication/domain/entities/session_with_user.dart';

abstract class RestoreSessionState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestoreSessionEmpty extends RestoreSessionState {}

class RestoreSessionLoading extends RestoreSessionState {}

class RestoreSessionLoaded extends RestoreSessionState {
  final SessionWithUserEntity session;

  RestoreSessionLoaded({required this.session});

  @override
  List<Object> get props => [session];
}

class RestoreSessionFailed extends RestoreSessionState {
  final String message;

  RestoreSessionFailed({required this.message});

  @override
  List<Object> get props => [message];
}
