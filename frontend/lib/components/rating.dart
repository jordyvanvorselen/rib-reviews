import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rib_reviews/utils/constants.dart';

class Rating extends StatelessWidget {
  final double rating;
  final double size;
  final bool showNumber;
  final bool readOnly;

  const Rating({
    Key? key,
    required this.rating,
    this.size = 20,
    this.showNumber = true,
    this.readOnly = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        showNumber
            ? Row(
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
              )
            : const SizedBox(),
        RatingBar.builder(
          ignoreGestures: readOnly,
          initialRating: rating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemSize: size,
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
