import 'package:flutter/material.dart';
import 'package:rib_reviews/components/timeline.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/common.dart';
import 'package:rib_reviews/utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar(user, context),
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
