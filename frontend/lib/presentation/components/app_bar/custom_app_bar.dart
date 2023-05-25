import 'package:flutter/material.dart';
import 'package:rib_reviews/domain/models/user.dart';
import 'package:rib_reviews/domain/utils/responsive.dart';
import 'package:rib_reviews/presentation/components/app_bar/app_bar_title.dart';
import 'package:rib_reviews/presentation/components/app_bar/profile_picture.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.user,
    required this.context,
    this.showLogo = true,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super();

  final User user;
  final BuildContext context;
  final bool showLogo;

  @override
  final Size preferredSize; // default is 56.0

  @override
  // ignore: library_private_types_in_public_api
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
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
            if (widget.showLogo)
              SizedBox(width: 55, child: Image.asset("assets/images/logo.png")),
            SizedBox(width: Responsive.appBarSpacing(context)),
            const AppBarTitle(),
            SizedBox(width: Responsive.appBarSpacing(context)),
            ProfilePicture(photoUrl: widget.user.photoUrlWithFallback)
          ],
        ),
      ),
      toolbarHeight: 75,
    );
  }
}
