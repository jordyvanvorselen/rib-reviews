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
    Color indicator = getIndicatorColor(event.date);

    return TimelineTile(
      indicatorStyle: getIndicatorStyle(indicator),
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
            padding: EdgeInsets.all(15.0),
            child: EventCard(
              name: event.venue.name,
              location: event.venue.location,
            )),
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
      return getIndicatorColor(events[idx].date);
    }

    return getIndicatorColor(lineType == LineType.before
        ? events[idx - 1].date
        : events[idx + 1].date);
  }

  Color getIndicatorColor(DateTime? date) {
    if (date == null) {
      return Colors.grey;
    }

    if (date.difference(DateTime.now()).isNegative) {
      return Colors.green;
    }

    return Colors.orange;
  }

  getIconByColor(Color color) {
    if (color.value == Colors.grey.value) {
      return Icons.pending;
    } else if (color.value == Colors.green.value) {
      return Icons.done;
    } else {
      return Icons.event;
    }
  }

  IndicatorStyle getIndicatorStyle(Color color) {
    return IndicatorStyle(
      color: color,
      padding: EdgeInsets.all(5),
      width: 50.0,
      iconStyle: IconStyle(
        color: Colors.white,
        iconData: getIconByColor(color),
        fontSize: 35.0,
      ),
    );
  }
}

enum LineType { before, after }
