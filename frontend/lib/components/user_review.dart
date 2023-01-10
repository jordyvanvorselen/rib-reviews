import 'package:flutter/material.dart';
import 'package:rib_reviews/components/generic_box_shadow.dart';
import 'package:rib_reviews/components/profile_picture.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/models/review.dart';

import '../utils/constants.dart';

class UserReview extends StatelessWidget {
  final Review review;

  const UserReview({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericBoxShadow(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    ProfilePicture(
                        photoUrl: review.user.getPhotoUrl(), radius: 20),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.user.displayName,
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            review.getFormattedDate(),
                            style: const TextStyle(
                                fontSize: 12, color: kSecondaryTextColor),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Rating(rating: review.rating, showNumber: false)
                  ],
                ),
                Divider(),
                Text(
                  review.text,
                  style:
                      const TextStyle(color: kSecondaryTextColor, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
