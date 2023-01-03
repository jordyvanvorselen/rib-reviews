import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class EventDate extends StatelessWidget {
  const EventDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 140, child: Text("Aug 8, 2023")),
        Container(
            width: 140,
            child: Text(
              "19:00:00",
              style: TextStyle(color: kSecondaryTextColor),
            )),
      ],
    );
  }
}
