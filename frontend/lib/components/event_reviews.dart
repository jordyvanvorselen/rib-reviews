import 'package:flutter/material.dart';
import 'package:rib_reviews/components/profile_picture.dart';
import 'package:rib_reviews/models/review.dart';

import '../../../utils/constants.dart';

class EventReviews extends StatelessWidget {
  final List<Review> reviews;

  const EventReviews({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 140,
          child: Text(
            "${reviews.length} reviews",
            style: const TextStyle(
              color: kSecondaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 7.5),
        Container(
          width: 140,
          child: Row(children: [
            const SizedBox(width: 7.5),
            ...reviews.take(5).map(
              (review) {
                return Align(
                  widthFactor: 0.5,
                  child: CircleAvatar(
                    radius: 17.5,
                    backgroundColor: kPrimaryColor,
                    child: ProfilePicture(
                      photoUrl: review.user.getPhotoUrl(),
                      radius: 15,
                    ),
                  ),
                );
              },
            ).toList(),
            const SizedBox(height: 32.5)
          ]),
        )
      ],
    );
  }
}
