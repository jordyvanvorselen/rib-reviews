import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String photoUrl;

  const ProfilePicture({Key? key, required this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      child: ClipOval(child: Image.network(photoUrl)),
    );
  }
}
