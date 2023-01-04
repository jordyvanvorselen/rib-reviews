import 'package:flutter/material.dart';
import 'package:rib_reviews/components/app_bar_title.dart';
import 'package:rib_reviews/components/profile_picture.dart';
import 'package:rib_reviews/models/user.dart';

class Common {
  static AppBar appBar(User user, {bool showLogo = true}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leadingWidth: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (showLogo)
            SizedBox(width: 55, child: Image.asset("assets/images/logo.png")),
          const AppBarTitle(),
          ProfilePicture(photoUrl: user.getPhotoUrl())
        ],
      ),
      toolbarHeight: 75,
    );
  }
}
