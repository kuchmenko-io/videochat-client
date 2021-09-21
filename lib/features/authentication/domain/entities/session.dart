import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  SessionEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
