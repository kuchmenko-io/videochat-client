import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatar;

  const ProfileAvatar({Key? key, this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(avatar!),
      ),
    );
  }
}
