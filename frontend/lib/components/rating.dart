import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rib_reviews/utils/constants.dart';

class Rating extends StatelessWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "4.3",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              " / ",
              style: TextStyle(fontSize: 10, color: kSecondaryTextColor),
            ),
            Text(
              "5",
              style: TextStyle(fontSize: 14, color: kSecondaryTextColor),
            )
          ],
        ),
        RatingBar.builder(
          ignoreGestures: true,
          initialRating: 3,
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
