import 'package:flutter/material.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/components/review_alert.dart';
import 'package:rib_reviews/components/review_screen_title.dart';
import 'package:rib_reviews/components/user_review.dart';
import 'package:rib_reviews/models/event.dart';

class ReviewScreen extends StatelessWidget {
  final Event event;

  const ReviewScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                children: [
                  ReviewScreenTitle(event: event),
                  const Spacer(),
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
