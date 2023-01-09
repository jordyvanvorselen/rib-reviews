import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/models/venue.dart';

import '../models/event.dart';

class EventsRepository {
  static Future<List<Event>> getEvents() async {
    var client = http.Client();

    try {
      var uri = Env.localhost == 'true' ? Uri.http : Uri.https;

      var reviewsUrl = uri(Env.apiUrl, '/api/reviews');
      var eventsUrl = uri(Env.apiUrl, '/api/events');
      var usersUrl = uri(Env.apiUrl, '/api/users');
      var venuesUrl = uri(Env.apiUrl, '/api/venues');

      var reviewsResponse = await get(client, reviewsUrl);
      var eventsResponse = await get(client, eventsUrl);
      var usersResponse = await get(client, usersUrl);
      var venuesResponse = await get(client, venuesUrl);

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
    } finally {
      client.close();
    }
  }

  static Future<String> get(http.Client client, Uri url) {
    return client.read(url, headers: {"Authorization": Env.apiKey});
  }
}
