import 'package:flutter/material.dart';
import 'package:rib_reviews/domain/models/event.dart';

import '../../domain/utils/constants.dart';

class ReviewScreenTitle extends StatelessWidget {
  final Event event;

  const ReviewScreenTitle({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          event.venue.name,
          style: const TextStyle(fontSize: 32),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          event.venue.location,
          style: const TextStyle(
            fontSize: 18,
            color: kSecondaryTextColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
