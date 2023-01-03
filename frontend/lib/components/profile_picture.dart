import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String? photoUrl;

  const ProfilePicture({Key? key, required this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return photoUrl == null
        ? const CircleAvatar(radius: 25)
        : CircleAvatar(
            radius: 25,
            child: ClipOval(child: Image.network(photoUrl!)),
          );
  }
}
