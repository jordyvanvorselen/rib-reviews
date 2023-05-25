import 'package:flutter/material.dart';
import 'package:rib_reviews/domain/models/event.dart';
import 'package:rib_reviews/domain/models/user.dart';
import 'package:rib_reviews/presentation/components/generic/generic_box_shadow.dart';
import 'package:rib_reviews/presentation/components/generic/rating.dart';
import 'package:rib_reviews/presentation/components/timeline/event_date.dart';
import 'package:rib_reviews/presentation/components/timeline/event_link.dart';
import 'package:rib_reviews/presentation/components/timeline/event_reviews.dart';
import 'package:rib_reviews/presentation/screens/review_screen.dart';

import '../../../domain/utils/constants.dart';
import 'event_title.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final User user;

  const EventCard({
    Key? key,
    required this.event,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!event.finished) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewScreen(event: event, currentUser: user),
          ),
        );
      },
      child: GenericBoxShadow(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: 210,
            height: 160,
            color: kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EventTitle(
                        name: event.venue.name,
                        location: event.venue.location,
                      ),
                      const SizedBox(height: 25.0),
                      event.finished
                          ? EventReviews(reviews: event.reviews)
                          : EventDate(event: event)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      event.finished
                          ? Rating(rating: event.totalRating)
                          : EventLink(event: event)
                    ],
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
