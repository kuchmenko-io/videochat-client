import 'package:equatable/equatable.dart';

abstract class SignInSessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInSession extends SignInSessionEvent {}
