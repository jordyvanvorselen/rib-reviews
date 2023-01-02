import 'package:flutter/material.dart';
import 'package:rib_reviews/models/event.dart';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
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
                  EventTitle(
                    name: this.event.venue.name,
                    location: this.event.venue.location,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
