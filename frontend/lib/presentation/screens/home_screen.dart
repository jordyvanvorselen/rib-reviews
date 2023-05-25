import 'package:flutter/material.dart';
import 'package:rib_reviews/domain/models/user.dart';
import 'package:rib_reviews/domain/utils/responsive.dart';
import 'package:rib_reviews/presentation/components/app_bar/custom_app_bar.dart';
import 'package:rib_reviews/presentation/components/timeline/timeline.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: user, context: context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.horizontalPadding(context),
          ),
          child: Row(
            children: [const SizedBox(width: 15.0), Timeline(user: user)],
          ),
        ),
      ),
    );
  }
}
