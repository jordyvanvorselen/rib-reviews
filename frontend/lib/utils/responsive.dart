import 'package:flutter/widgets.dart';

class Responsive {
  static double appBarSpacing(BuildContext context) {
    final modifier = isWeb(context) ? 0.18 : 0.15;

    return width(context) * modifier;
  }

  static double horizontalPadding(BuildContext context, {bool appbar = false}) {
    final padding = isWeb(context) ? width(context) * 0.25 : 0.0;

    return appbar ? padding * 0.6 : padding;
  }

  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
