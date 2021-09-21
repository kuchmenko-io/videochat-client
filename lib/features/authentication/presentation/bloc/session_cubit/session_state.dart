import 'package:equatable/equatable.dart';
import 'package:videochat_client/features/authentication/domain/entities/session_with_user.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionStateEmpty extends SessionState {
  @override
  List<Object> get props => [];
}

class SessionStateLoading extends SessionState {
  final bool isRestoringSession;

  SessionStateLoading({this.isRestoringSession = true});

  @override
  List<Object> get props => [isRestoringSession];
}

class SessionStateLoaded extends SessionState {
  final SessionWithUserEntity session;

  SessionStateLoaded({required this.session});

  @override
  List<Object> get props => [session];
}

class SessionStateFailure extends SessionState {
  final String message;

  SessionStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}
