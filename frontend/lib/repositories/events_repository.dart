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
      var reviewsUrl = Uri.https(Env.apiUrl, '/api/reviews');
      var eventsUrl = Uri.https(Env.apiUrl, '/api/events');
      var usersUrl = Uri.https(Env.apiUrl, '/api/users');
      var venuesUrl = Uri.https(Env.apiUrl, '/api/venues');

      var reviewsResponse = await get(client, reviewsUrl);
      var eventsResponse = await get(client, eventsUrl);
      var usersResponse = await get(client, usersUrl);
      var venuesResponse = await get(client, venuesUrl);

      List<dynamic> rawReviews = jsonDecode(reviewsResponse);
      List<dynamic> rawEvents = jsonDecode(eventsResponse);
      List<dynamic> rawUsers = jsonDecode(usersResponse);
      List<dynamic> rawVenues = jsonDecode(venuesResponse);

      List<User> users = rawUsers.map((raw) => toUser(raw)).toList();
      List<Venue> venues = rawVenues.map((raw) => toVenue(raw)).toList();
      List<Review> reviews =
          rawReviews.map((raw) => toReview(raw, users)).toList();
      List<Event> events =
          rawEvents.map((raw) => toEvent(raw, venues, reviews)).toList();

      reviews.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));
      events.sort(
          ((a, b) => b.date?.compareTo(a?.date ?? DateTime(3000)) ?? 99999999));

      return events;
    } finally {
      client.close();
    }
  }

  static User toUser(dynamic user) {
    return User(
      id: user['_id'],
      displayName: user['displayName'],
      email: user['email'],
      photoUrl: user['photoUrl'],
    );
  }

  static Venue toVenue(dynamic venue) {
    return Venue(
      id: venue['_id'],
      location: venue['location'],
      name: venue['name'],
      website: venue['website'],
    );
  }

  static Review toReview(dynamic review, List<User> users) {
    User user = users.firstWhere((u) => u.id == review['userId']);

    return Review(
        id: review['_id'],
        rating: review['rating'],
        text: review['text'],
        user: user,
        createdAt: DateTime.parse(review['createdAt']),
        eventId: review['eventId']);
  }

  static Event toEvent(
      dynamic event, List<Venue> venues, List<Review> reviews) {
    Venue venue = venues.firstWhere((v) => v.id == event['venueId']);
    List<Review> eventReviews =
        reviews.where((r) => r.eventId == event['_id']).toList();

    return Event(
      id: event['_id'],
      date: event['date'] != null ? DateTime.parse(event['date']) : null,
      venue: venue,
      reviews: eventReviews,
    );
  }

  static Future<String> get(http.Client client, Uri url) {
    return client.read(url, headers: {"Authorization": Env.apiKey});
  }
}
