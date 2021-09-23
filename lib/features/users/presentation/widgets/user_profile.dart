import 'package:flutter/material.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';
import 'package:videochat_client/features/users/presentation/widgets/profile_avatar.dart';

class UserProfile extends StatelessWidget {
  final UserEntity user;

  const UserProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ProfileAvatar(
                avatar: user.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(user.fullName,
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                user.getUsername(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
