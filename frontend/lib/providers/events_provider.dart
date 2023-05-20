import 'package:flutter/material.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/repositories/events_repository.dart';
import 'package:rib_reviews/repositories/reviews_repository.dart';
import 'package:rib_reviews/repositories/users_repository.dart';
import 'package:rib_reviews/repositories/venues_repository.dart';

class EventsProvider with ChangeNotifier {
  VenuesRepository venuesRepository;
  UsersRepository usersRepository;
  ReviewsRepository reviewsRepository;
  EventsRepository eventsRepository;

  List<Event> _events = [];
  List<Event> get events => _events;

  EventsProvider({
    required this.venuesRepository,
    required this.usersRepository,
    required this.reviewsRepository,
    required this.eventsRepository,
  });

  void addReview(Review review, Event event) {
    debugPrint(_events.map((e) => e.id).toList().toString());
    debugPrint(event.id.toString());
    _events.firstWhere((e) => e.id == event.id).reviews.insert(0, review);
    notifyListeners();
  }

  void fetchEvents() async {
    final venues = await venuesRepository.all();
    final users = await usersRepository.all();
    final reviews = await reviewsRepository.all(users);

    _events = await eventsRepository.all(venues, reviews);

    notifyListeners();
  }
}
