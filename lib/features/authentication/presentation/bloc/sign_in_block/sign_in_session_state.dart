import 'package:equatable/equatable.dart';
import 'package:videochat_client/features/authentication/domain/entities/session_with_user.dart';

abstract class SignInSessionState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInSessionEmpty extends SignInSessionState {}

class SignInSessionLoading extends SignInSessionState {}

class SignInSessionLoaded extends SignInSessionState {
  final SessionWithUserEntity session;

  SignInSessionLoaded({required this.session});

  @override
  List<Object> get props => [session];
}

class SignInSessionFailed extends SignInSessionState {
  final String message;

  SignInSessionFailed({required this.message});

  @override
  List<Object> get props => [message];
}
