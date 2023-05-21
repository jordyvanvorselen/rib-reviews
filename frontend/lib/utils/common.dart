import 'package:flutter/material.dart';
import 'package:rib_reviews/components/app_bar_title.dart';
import 'package:rib_reviews/components/profile_picture.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/responsive.dart';

class Common {
  static AppBar appBar(
    User user,
    BuildContext context, {
    bool showLogo = true,
  }) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context, appbar: true),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLogo)
              SizedBox(width: 55, child: Image.asset("assets/images/logo.png")),
            SizedBox(width: Responsive.appBarSpacing(context)),
            const AppBarTitle(),
            SizedBox(width: Responsive.appBarSpacing(context)),
            ProfilePicture(photoUrl: user.getPhotoUrl())
          ],
        ),
      ),
      toolbarHeight: 75,
    );
  }
}
