import 'package:flutter/material.dart';

import './event_title.dart';
import '../../../../utils/constants.dart';

class EventCard extends StatelessWidget {
  final String name;
  final String location;

  const EventCard({
    Key? key,
    required this.name,
    required this.location,
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
                    name: this.name,
                    location: this.location,
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
