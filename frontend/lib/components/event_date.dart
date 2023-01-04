import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rib_reviews/models/event.dart';

import '../../../../utils/constants.dart';

class EventDate extends StatelessWidget {
  final Event event;

  const EventDate({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 140, child: Text(getFormattedDate(event.date))),
        SizedBox(
          width: 140,
          child: Text(
            getFormattedTime(event.date),
            style: const TextStyle(color: kSecondaryTextColor),
          ),
        ),
      ],
    );
  }

  String getFormattedDate(DateTime? date) {
    return date == null ? "" : DateFormat.yMMMMd('en_US').format(date);
  }

  String getFormattedTime(DateTime? date) {
    return date == null
        ? "Not planned yet"
        : DateFormat.Hms('en_US').format(date);
  }
}
