import 'package:flutter/material.dart';

class GenericBoxShadow extends StatelessWidget {
  final Widget child;

  const GenericBoxShadow({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 20,
          spreadRadius: 5,
          color: Colors.black.withOpacity(0.2),
        )
      ]),
      child: child,
    );
  }
}
