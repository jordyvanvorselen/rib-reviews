import 'package:flutter/material.dart';

import 'utils/constants.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rib Reviews",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: kPrimaryTextColor, fontFamily: 'Onest'),
        iconTheme: const IconThemeData(color: kPrimaryTextColor),
      ),
    );
  }
}
