import 'package:flutter/material.dart';
import 'package:rib_reviews/domain/models/review.dart';
import 'package:rib_reviews/presentation/components/app_bar/profile_picture.dart';

import '../../../domain/utils/constants.dart';

class EventReviews extends StatelessWidget {
  final List<Review> reviews;

  const EventReviews({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
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
        SizedBox(
          width: 140,
          child: Row(children: [
            const SizedBox(width: 7.5),
            ...(reviews.isNotEmpty
                ? reviews.take(5).map(
                    (review) {
                      return Align(
                        widthFactor: 0.5,
                        child: CircleAvatar(
                          radius: 17.5,
                          backgroundColor: kPrimaryColor,
                          child: ProfilePicture(
                            photoUrl: review.user.photoUrlWithFallback,
                            radius: 15,
                          ),
                        ),
                      );
                    },
                  ).toList()
                : [
                    const Text("-",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryTextColor))
                  ]),
            const SizedBox(height: 32.5)
          ]),
        )
      ],
    );
  }
}
