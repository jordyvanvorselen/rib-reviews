import 'package:flutter/material.dart';
import 'package:rib_reviews/domain/utils/responsive.dart';
import 'package:rib_reviews/presentation/components/generic/rating.dart';
import 'package:rib_reviews/presentation/components/review_screen_title.dart';
import 'package:rib_reviews/presentation/screens/review_screen.dart';

class ReviewHeader extends StatelessWidget {
  const ReviewHeader({
    super.key,
    required this.widget,
  });

  final ReviewScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context) + 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReviewScreenTitle(event: widget.event),
          Rating(rating: widget.event.totalRating),
        ],
      ),
    );
  }
}
