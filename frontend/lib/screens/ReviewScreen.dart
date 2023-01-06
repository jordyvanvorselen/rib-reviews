import 'package:flutter/material.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/components/review_alert.dart';
import 'package:rib_reviews/components/review_screen_title.dart';
import 'package:rib_reviews/components/user_review.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/services/review_save_service.dart';
import 'package:rib_reviews/utils/common.dart';

class ReviewScreen extends StatefulWidget {
  final Event event;
  final User user;

  const ReviewScreen({Key? key, required this.event, required this.user})
      : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar(widget.user, showLogo: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ReviewAlert().show(context, widget.event, (rating, text) async {
            try {
              isSaving = true;
              await ReviewSaveService.save(
                  rating, text, widget.user, widget.event);
            } finally {
              isSaving = false;
            }
          });
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
                  ReviewScreenTitle(event: widget.event),
                  Rating(rating: widget.event.getTotalRating())
                ],
              ),
              const SizedBox(height: 15),
              const Divider(),
              Expanded(
                child: ListView(
                  children: widget.event.reviews
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
