import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rib_reviews/presentation/screens/login_screen.dart';

import 'domain/utils/constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: kBackgroundColor,
    statusBarBrightness: Brightness.light,
  ));

  runApp(const ProviderScope(child: Main()));
}

class Main extends StatelessWidget {
  const Main({Key? key, this.overrideWidget}) : super(key: key);

  final Widget? overrideWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rib Reviews",
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior().copyWith(scrollbars: false),
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: kPrimaryTextColor, fontFamily: 'Onest'),
        iconTheme: const IconThemeData(color: kPrimaryTextColor),
        appBarTheme: const AppBarTheme(backgroundColor: kBackgroundColor),
      ),
      home: overrideWidget ?? const LoginScreen(),
    );
  }
}
