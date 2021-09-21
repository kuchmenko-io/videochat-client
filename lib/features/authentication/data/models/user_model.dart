import 'package:json_annotation/json_annotation.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  @JsonKey(name: 'sub')
  final String id;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'nickname')
  final String username;

  @JsonKey(name: 'phone')
  final String? phoneNumber;

  @JsonKey(name: 'picture')
  final String image;

  @JsonKey(name: 'given_name')
  final String firstName;

  @JsonKey(name: 'family_name')
  final String lastName;

  @JsonKey(name: 'name')
  final String fullName;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.fullName,
  }) : super(
          id: id,
          email: email,
          username: username,
          phoneNumber: phoneNumber,
          image: image,
          firstName: firstName,
          lastName: lastName,
          fullName: fullName,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
