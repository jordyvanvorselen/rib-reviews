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
              child: Column(
                children: [
                  EventTitle(
                    name: this.event.venue.name,
                    location: this.event.venue.location,
                  ),
                  SizedBox(height: 25.0),
                  Column(
                    children: [
                      Container(
                        width: 150,
                        child: Text(
                          "4 reviews",
                          style: TextStyle(
                            color: kSecondaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 7.5),
                      Container(
                        width: 150,
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            for (int i = 0; i < 3; i++)
                              Align(
                                widthFactor: 0.5,
                                child: CircleAvatar(
                                    radius: 17.5,
                                    backgroundColor: kPrimaryColor,
                                    child: CircleAvatar(
                                      radius: 15,
                                    )),
                              )
                          ],
                        ),
                      )
                    ],
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
