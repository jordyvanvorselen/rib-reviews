import 'package:flutter/material.dart';
import 'package:rib_reviews/components/event_date.dart';
import 'package:rib_reviews/components/event_link.dart';
import 'package:rib_reviews/components/event_reviews.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/screens/ReviewScreen.dart';

import './event_title.dart';
import '../../../../utils/constants.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!event.finished()) {
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewScreen(event: event),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 210,
          height: 160,
          color: kPrimaryColor,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 20,
                child: Row(
                  children: [
                    Column(
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
                    const SizedBox(width: 5.0),
                    Column(
                      children: [
                        event.finished()
                            ? Rating(rating: event.getTotalRating())
                            : EventLink(event: event)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
