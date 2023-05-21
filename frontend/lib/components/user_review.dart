import 'package:flutter/material.dart';
import 'package:rib_reviews/components/emoji_reaction.dart';
import 'package:rib_reviews/components/generic_box_shadow.dart';
import 'package:rib_reviews/components/profile_picture.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/models/reaction.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/utils/responsive.dart';

import '../utils/constants.dart';

class UserReview extends StatelessWidget {
  final Review review;
  final List<Reaction> reactions;
  final VoidCallback onReaction;

  const UserReview({
    Key? key,
    required this.review,
    required this.onReaction,
    required this.reactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context) + 25),
      child: GenericBoxShadow(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            color: kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
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
                  const Divider(),
                  Text(
                    review.text,
                    style: const TextStyle(
                        color: kSecondaryTextColor, fontSize: 14),
                  ),
                  Row(children: [
                    IconButton(
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      color: const Color.fromARGB(150, 255, 255, 255),
                      onPressed: onReaction,
                      icon: const Icon(
                        Icons.add_reaction_outlined,
                      ),
                    ),
                    ...reactions
                        .take(Responsive.isWeb(context) ? 21 : 6)
                        .map((r) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: EmojiReaction(
                                emoji: r.emoji,
                                timesReacted: r.users.length,
                              ),
                            ))
                        .toList()
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
