// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_id_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionIdTokenModel _$SessionIdTokenModelFromJson(Map<String, dynamic> json) {
  return SessionIdTokenModel(
    givenName: json['givenName'],
    familyName: json['familyName'],
    nickname: json['nickname'],
    name: json['name'],
    picture: json['picture'],
    locale: json['locale'],
    email: json['email'],
    emailVerified: json['emailVerified'],
  );
}

Map<String, dynamic> _$SessionIdTokenModelToJson(
        SessionIdTokenModel instance) =>
    <String, dynamic>{
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'nickname': instance.nickname,
      'name': instance.name,
      'picture': instance.picture,
      'locale': instance.locale,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
    };
