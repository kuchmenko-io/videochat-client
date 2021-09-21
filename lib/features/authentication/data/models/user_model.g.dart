// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['sub'] as String,
    email: json['email'] as String?,
    username: json['nickname'] as String,
    phoneNumber: json['phone'] as String?,
    image: json['picture'] as String,
    firstName: json['given_name'] as String,
    lastName: json['family_name'] as String,
    fullName: json['name'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'sub': instance.id,
      'email': instance.email,
      'nickname': instance.username,
      'phone': instance.phoneNumber,
      'picture': instance.image,
      'given_name': instance.firstName,
      'family_name': instance.lastName,
      'name': instance.fullName,
    };
