import 'package:flutter/material.dart';
import 'package:rib_reviews/domain/models/reaction.dart';
import 'package:rib_reviews/domain/models/review.dart';
import 'package:rib_reviews/domain/models/user.dart';
import 'package:rib_reviews/presentation/components/app_bar/profile_picture.dart';
import 'package:rib_reviews/presentation/components/generic/generic_box_shadow.dart';
import 'package:rib_reviews/presentation/components/generic/rating.dart';
import 'package:rib_reviews/presentation/components/review/emoji_reaction.dart';
import 'package:rib_reviews/domain/utils/responsive.dart';

import '../../../domain/utils/constants.dart';

class UserReview extends StatelessWidget {
  final User currentUser;
  final Review review;
  final List<Reaction> reactions;
  final VoidCallback onReaction;
  final void Function(Reaction) onReactionTap;

  const UserReview({
    Key? key,
    required this.review,
    required this.onReaction,
    required this.reactions,
    required this.currentUser,
    required this.onReactionTap,
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
                          photoUrl: review.user.photoUrlWithFallback,
                          radius: 20),
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
                              review.formattedDate,
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
                  const SizedBox(height: 5),
                  Text(
                    review.text,
                    style: const TextStyle(
                        color: kSecondaryTextColor, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 20,
                          padding: const EdgeInsets.only(right: 10),
                          constraints: const BoxConstraints(),
                          alignment: Alignment.center,
                          color: const Color.fromARGB(150, 255, 255, 255),
                          onPressed: onReaction,
                          icon: const Icon(
                            Icons.add_reaction_outlined,
                          ),
                        ),
                        Flexible(
                          child: Wrap(
                            runSpacing: 10,
                            children: [
                              ...reactions
                                  .map((r) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: EmojiReaction(
                                          currentUser: currentUser,
                                          reaction: r,
                                          onTap: onReactionTap,
                                        ),
                                      ))
                                  .toList()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}