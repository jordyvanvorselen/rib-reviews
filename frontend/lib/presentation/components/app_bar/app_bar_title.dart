import 'package:flutter/material.dart';
import 'package:rib_reviews/domain/utils/constants.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Welcome to",
          style: TextStyle(color: kSecondaryTextColor, fontSize: 16),
        ),
        Text(
          "The Eat Guild",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
