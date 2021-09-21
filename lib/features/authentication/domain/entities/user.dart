import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String username;
  final String? phoneNumber;
  final String image;
  final String firstName;
  final String lastName;
  final String fullName;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        phoneNumber,
        image,
        firstName,
        lastName,
        fullName,
      ];
}
