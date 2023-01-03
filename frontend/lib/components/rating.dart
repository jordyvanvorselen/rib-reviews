import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rib_reviews/utils/constants.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 28),
            ),
            const Text(
              " / ",
              style: TextStyle(fontSize: 10, color: kSecondaryTextColor),
            ),
            const Text(
              "5",
              style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
            )
          ],
        ),
        RatingBar.builder(
          ignoreGestures: true,
          initialRating: rating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemSize: 20,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (_) {},
        ),
      ],
    );
  }
}
