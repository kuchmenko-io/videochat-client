import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatar;
  final String name;

  const ProfileAvatar({Key? key, this.avatar, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        radius: 30,
        child: avatar == null ? Text(name) : null,
        backgroundImage: avatar != null ? NetworkImage(avatar!) : null,
      ),
    );
  }
}
