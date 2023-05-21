import 'package:flutter/widgets.dart';

class Screen {
  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800;
  }
}
