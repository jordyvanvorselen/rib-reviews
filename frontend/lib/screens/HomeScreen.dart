import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:rib_reviews/components/app_bar_title.dart';
import 'package:rib_reviews/components/profile_picture.dart';
import 'package:rib_reviews/components/timeline.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String? photoUrl;
  final String email;

  const HomeScreen({
    Key? key,
    required this.username,
    required this.photoUrl,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String profilePicUrl =
        photoUrl ?? "https://www.gravatar.com/avatar/${generateMd5(email)}";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            SizedBox(width: 65, child: Image.asset("assets/images/logo.png")),
            const SizedBox(width: 60),
            const AppBarTitle(),
          ],
        ),
        toolbarHeight: 75,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: ProfilePicture(photoUrl: profilePicUrl))
        ],
      ),
      body: SafeArea(
        child: Row(
          children: const [SizedBox(width: 15.0), Timeline()],
        ),
      ),
    );
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
