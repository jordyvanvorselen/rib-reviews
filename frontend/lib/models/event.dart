import 'package:flutter/material.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:timeline_tile/timeline_tile.dart';

import './venue.dart';

enum EventState { unplanned, planned, finished }

class Event {
  final String id;
  final List<Review> reviews;
  final DateTime? date;
  final Venue venue;

  Event(
      {required this.id,
      required this.date,
      required this.venue,
      required this.reviews});

  factory Event.fromJson(Map json, Venue venue, List<Review> reviews) {
    return Event(
      id: json['_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      venue: venue,
      reviews: reviews,
    );
  }

  EventState getState() {
    if (date == null) {
      return EventState.unplanned;
    } else if (date!.difference(DateTime.now()).isNegative) {
      return EventState.finished;
    } else {
      return EventState.planned;
    }
  }

  bool unplanned() {
    return getState() == EventState.unplanned;
  }

  bool planned() {
    return getState() == EventState.planned;
  }

  bool finished() {
    return getState() == EventState.finished;
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

  double getTotalRating() {
    if (reviews.isEmpty) return 0;

    return reviews
            .map((r) => r.rating)
            .reduce((value, element) => value + element) /
        reviews.length;
  }

  IndicatorStyle getIndicatorStyle() {
    return IndicatorStyle(
      color: getIndicatorColor(),
      padding: const EdgeInsets.all(5),
      width: 50.0,
      iconStyle: IconStyle(
        color: Colors.white,
        iconData: getIcon(),
        fontSize: 35.0,
      ),
    );
  }
}
