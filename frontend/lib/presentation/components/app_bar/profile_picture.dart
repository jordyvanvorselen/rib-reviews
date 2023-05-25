import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String photoUrl;
  final double radius;

  const ProfilePicture({Key? key, required this.photoUrl, this.radius = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: ClipOval(child: Image.network(photoUrl)),
    );
  }
}
