import 'package:equatable/equatable.dart';

abstract class RestoreSessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RestoreSession extends RestoreSessionEvent {}
