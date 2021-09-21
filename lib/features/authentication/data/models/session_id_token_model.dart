import 'package:json_annotation/json_annotation.dart';
import 'package:videochat_client/features/authentication/domain/entities/session_id_token.dart';

part 'session_id_token_model.g.dart';

@JsonSerializable()
class SessionIdTokenModel extends SessionIdTokenEntity {
  SessionIdTokenModel({
    required givenName,
    required familyName,
    required nickname,
    required name,
    required picture,
    required locale,
    required email,
    required emailVerified,
  }) : super(
          givenName: givenName,
          familyName: familyName,
          nickname: nickname,
          name: name,
          picture: picture,
          locale: locale,
          email: email,
          emailVerified: emailVerified,
        );

  factory SessionIdTokenModel.fromJson(Map<String, dynamic> json) =>
      _$SessionIdTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionIdTokenModelToJson(this);
}
