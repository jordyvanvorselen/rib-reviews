import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class EventTitle extends StatelessWidget {
  final String name;
  final String location;

  const EventTitle({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            location,
            style: const TextStyle(
              fontSize: 16,
              color: kSecondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
