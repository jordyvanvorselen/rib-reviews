import 'dart:convert';

import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/venue.dart';
import 'package:rib_reviews/utils/api.dart';

import '../models/event.dart';

class EventsRepository {
  static Future<List<Event>> all(
      List<Venue> venues, List<Review> reviews) async {
    try {
      final eventsUrl = Env.apiUrl("/events");
      final eventsResponse = await API.get(eventsUrl);

      List<Event> events = jsonDecode(eventsResponse)
          .map<Event>((raw) => Event.fromJson(
              raw,
              venues.firstWhere((v) => v.id == raw['venueId']),
              reviews.where((r) => r.eventId == raw['_id']).toList()))
          .toList();

      events.sort(
          ((a, b) => b.date?.compareTo(a.date ?? DateTime(3000)) ?? 99999999));

      return events;
    } on Exception catch (_) {
      return Future.error("Could not fetch data from server.");
    }
  }
}
