import 'package:videochat_client/features/authentication/domain/entities/session.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';

class SessionWithUserEntity extends SessionEntity {
  final UserEntity user;

  SessionWithUserEntity({
    required accessToken,
    required refreshToken,
    required this.user,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  @override
  List<Object?> get props => [user, accessToken, refreshToken];

  factory SessionWithUserEntity.fromSession({
    required SessionEntity session,
    required UserEntity user,
  }) {
    return SessionWithUserEntity(
        accessToken: session.accessToken,
        refreshToken: session.refreshToken,
        user: user);
  }
}
