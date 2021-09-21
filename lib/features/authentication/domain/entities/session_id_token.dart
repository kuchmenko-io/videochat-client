import 'package:equatable/equatable.dart';

class SessionIdTokenEntity extends Equatable {
  final String givenName;
  final String familyName;
  final String nickname;
  final String name;
  final String picture;
  final String locale;
  final String email;
  final bool emailVerified;

  SessionIdTokenEntity({
    required this.givenName,
    required this.familyName,
    required this.nickname,
    required this.name,
    required this.picture,
    required this.locale,
    required this.email,
    required this.emailVerified,
  });

  @override
  List<Object?> get props => [
        givenName,
        familyName,
        nickname,
        name,
        picture,
        locale,
        email,
        emailVerified,
      ];
}
