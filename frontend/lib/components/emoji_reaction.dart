import 'package:flutter/material.dart';

class EmojiReaction extends StatelessWidget {
  final String emoji;
  final int timesReacted;

  const EmojiReaction({
    Key? key,
    required this.emoji,
    required this.timesReacted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(emoji), Text(timesReacted.toString())],
    );
  }
}
