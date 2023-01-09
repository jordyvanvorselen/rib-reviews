import 'dart:convert';

import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/models/venue.dart';
import 'package:rib_reviews/utils/api.dart';

import '../models/event.dart';

class EventsRepository {
  static Future<List<Event>> getEvents() async {
    try {
      final reviewsUrl = Env.apiUrl("/reviews");
      final eventsUrl = Env.apiUrl("/events");
      final usersUrl = Env.apiUrl("/users");
      final venuesUrl = Env.apiUrl("/venues");

      final reviewsResponse = await API.get(reviewsUrl);
      final eventsResponse = await API.get(eventsUrl);
      final usersResponse = await API.get(usersUrl);
      final venuesResponse = await API.get(venuesUrl);

      List<dynamic> rawReviews = jsonDecode(reviewsResponse);
      List<dynamic> rawEvents = jsonDecode(eventsResponse);
      List<dynamic> rawUsers = jsonDecode(usersResponse);
      List<dynamic> rawVenues = jsonDecode(venuesResponse);

      List<User> users = rawUsers.map((raw) => User.fromJson(raw)).toList();
      List<Venue> venues = rawVenues.map((raw) => Venue.fromJson(raw)).toList();
      List<Review> reviews = rawReviews
          .map((raw) => Review.fromJson(
                raw,
                users.firstWhere((u) => u.id == raw['userId']),
              ))
          .toList();
      List<Event> events = rawEvents
          .map((raw) => Event.fromJson(
              raw,
              venues.firstWhere((v) => v.id == raw['venueId']),
              reviews.where((r) => r.eventId == raw['_id']).toList()))
          .toList();

      reviews.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));
      events.sort(
          ((a, b) => b.date?.compareTo(a.date ?? DateTime(3000)) ?? 99999999));

      return events;
    } on Exception catch (_) {
      return Future.error("Could not fetch data from server.");
    }
  }
}
