import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class EventReviews extends StatelessWidget {
  const EventReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 140,
          child: const Text(
            "4 reviews",
            style: TextStyle(
              color: kSecondaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 7.5),
        Container(
          width: 140,
          child: Row(
            children: [
              const SizedBox(width: 5),
              for (int i = 0; i < 4; i++)
                const Align(
                  widthFactor: 0.5,
                  child: CircleAvatar(
                      radius: 17.5,
                      backgroundColor: kPrimaryColor,
                      child: CircleAvatar(
                        radius: 15,
                      )),
                )
            ],
          ),
        )
      ],
    );
  }
}
