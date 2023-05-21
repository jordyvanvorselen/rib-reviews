import 'package:flutter/material.dart';
import 'package:rib_reviews/models/reaction.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/constants.dart';

class EmojiReaction extends StatelessWidget {
  final Reaction reaction;
  final void Function(Reaction) onTap;
  final User currentUser;

  const EmojiReaction({
    Key? key,
    required this.currentUser,
    required this.reaction,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(reaction),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          height: 30,
          color: reaction.isPlacedBy(currentUser)
              ? kOwnReactionColor
              : kReactionColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(reaction.emoji),
              Text(reaction.users.length.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
