import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import './venue.dart';

enum EventState { unplanned, planned, finished }

class Event {
  final DateTime? date;
  final Venue venue;

  Event({required this.date, required this.venue});

  EventState getState() {
    if (date == null) {
      return EventState.unplanned;
    } else if (date!.difference(DateTime.now()).isNegative) {
      return EventState.finished;
    } else {
      return EventState.planned;
    }
  }

  Color getIndicatorColor() {
    switch (getState()) {
      case EventState.unplanned:
        return Colors.grey;
      case EventState.planned:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  IconData getIcon() {
    switch (getState()) {
      case EventState.unplanned:
        return Icons.pending;
      case EventState.planned:
        return Icons.event;
      default:
        return Icons.done;
    }
  }

  IndicatorStyle getIndicatorStyle() {
    return IndicatorStyle(
      color: getIndicatorColor(),
      padding: EdgeInsets.all(5),
      width: 50.0,
      iconStyle: IconStyle(
        color: Colors.white,
        iconData: getIcon(),
        fontSize: 35.0,
      ),
    );
  }
}
