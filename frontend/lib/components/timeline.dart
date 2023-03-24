import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rib_reviews/components/event_card.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/utils/constants.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../models/event.dart';
import '../providers/providers.dart';

class Timeline extends ConsumerStatefulWidget {
  final User user;
  const Timeline({Key? key, required this.user}) : super(key: key);

  @override
  TimelineState createState() => TimelineState();
}

class TimelineState extends ConsumerState<Timeline> {
  @override
  void initState() {
    ref.read(Providers.eventsProvider).fetchEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(Providers.eventsProvider).events.asMap();

    return Expanded(
      child: ListView(children: [
        if (events.isEmpty)
          Container(
            height: MediaQuery.of(context).size.height - 200,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        ...events.entries.map(
          (entry) {
            int idx = entry.key;
            Event event = entry.value;

            return getTimelineTile(
              ref.watch(Providers.eventsProvider).events,
              event,
              idx,
            );
          },
        ).toList(),
      ]),
    );
  }

  TimelineTile getTimelineTile(List<Event> events, Event event, int index) {
    return TimelineTile(
      indicatorStyle: event.getIndicatorStyle(),
      beforeLineStyle: LineStyle(
        color: getLineColor(events, index, LineType.before),
        thickness: 5,
      ),
      afterLineStyle: LineStyle(
        color: getLineColor(events, index, LineType.after),
        thickness: 5,
      ),
      endChild: Container(
        constraints: const BoxConstraints(minHeight: 200),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: EventCard(event: event, user: widget.user),
        ),
      ),
    );
  }

  Color getLineColor(List<Event> events, int idx, LineType lineType) {
    bool isFirst = idx == 0;
    bool isLast = idx + 1 == events.length;

    if ((isFirst && lineType == LineType.before) ||
        (isLast && lineType == LineType.after)) {
      return kBackgroundColor;
    }

    if (idx == 0) {
      return events[idx].getIndicatorColor();
    }

    final event = lineType == LineType.before ? events[idx - 1] : events[idx];

    return event.getIndicatorColor();
  }
}

enum LineType { before, after }
