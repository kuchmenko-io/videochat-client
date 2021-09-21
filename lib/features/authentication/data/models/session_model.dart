import 'package:json_annotation/json_annotation.dart';
import 'package:videochat_client/features/authentication/data/models/session_id_token_model.dart';
import 'package:videochat_client/features/authentication/domain/entities/session.dart';

part 'session_model.g.dart';

@JsonSerializable()
class SessionModel extends SessionEntity {
  SessionModel({
    required accessToken,
    required refreshToken,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
