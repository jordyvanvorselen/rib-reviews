import 'package:flutter/material.dart';
import 'package:rib_reviews/components/event_card.dart';
import 'package:rib_reviews/utils/constants.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../mocks/mock_events.dart';
import '../models/event.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Event> events = MockEvents.data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: events.asMap().entries.map((entry) {
          int idx = entry.key;
          Event event = entry.value;

          return getTimelineTile(event, idx);
        }).toList(),
      ),
    );
  }

  TimelineTile getTimelineTile(Event event, int index) {
    return TimelineTile(
      indicatorStyle: event.getIndicatorStyle(),
      beforeLineStyle: LineStyle(
        color: getLineColor(index, LineType.before),
        thickness: 5,
      ),
      afterLineStyle: LineStyle(
        color: getLineColor(index, LineType.after),
        thickness: 5,
      ),
      endChild: Container(
        constraints: const BoxConstraints(minHeight: 200),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: EventCard(event: event),
        ),
      ),
    );
  }

  Color getLineColor(int idx, LineType lineType) {
    bool isFirst = idx == 0;
    bool isLast = idx + 1 == events.length;

    if ((isFirst && lineType == LineType.before) ||
        (isLast && lineType == LineType.after)) {
      return kBackgroundColor;
    }

    if (idx == 0) {
      return events[idx].getIndicatorColor();
    }

    final event =
        lineType == LineType.before ? events[idx - 1] : events[idx + 1];

    return event.getIndicatorColor();
  }
}

enum LineType { before, after }
