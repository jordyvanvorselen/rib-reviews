import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rib_reviews/providers/events_provider.dart';
import 'package:rib_reviews/screens/LoginScreen.dart';

import 'utils/constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => EventsProvider()),
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rib Reviews",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: kPrimaryTextColor, fontFamily: 'Onest'),
        iconTheme: const IconThemeData(color: kPrimaryTextColor),
      ),
      home: LoginScreen(), // const messes with the navigation
    );
  }
}
