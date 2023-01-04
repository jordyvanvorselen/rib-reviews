import 'package:flutter/material.dart';
import 'package:rib_reviews/components/app_bar_title.dart';
import 'package:rib_reviews/components/profile_picture.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/components/review_alert.dart';
import 'package:rib_reviews/components/review_screen_title.dart';
import 'package:rib_reviews/components/user_review.dart';
import 'package:rib_reviews/main.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/common.dart';

class ReviewScreen extends StatelessWidget {
  final Event event;
  final User user;

  const ReviewScreen({Key? key, required this.event, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar(user, showLogo: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ReviewAlert().show(context, event);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.star, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReviewScreenTitle(event: event),
                  Rating(rating: event.getTotalRating())
                ],
              ),
              const SizedBox(height: 15),
              const Divider(),
              Expanded(
                child: ListView(
                  children: event.reviews
                      .map((review) => UserReview(review: review))
                      .fold<List<Widget>>(
                    [],
                    (value, element) {
                      value.add(SizedBox(height: 20));
                      value.add(element);

                      return value;
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
