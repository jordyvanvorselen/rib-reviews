import 'package:flutter/material.dart';
import 'package:rib_reviews/components/event_date.dart';
import 'package:rib_reviews/components/event_link.dart';
import 'package:rib_reviews/components/event_reviews.dart';
import 'package:rib_reviews/components/generic_box_shadow.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/screens/review_screen.dart';

import './event_title.dart';
import '../../../../utils/constants.dart';

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
        if (!event.finished()) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewScreen(event: event, user: user),
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
                      event.finished()
                          ? EventReviews(reviews: event.reviews)
                          : EventDate(event: event)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      event.finished()
                          ? Rating(rating: event.getTotalRating())
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
