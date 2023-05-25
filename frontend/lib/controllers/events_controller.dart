import 'package:flutter/material.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/repositories/events_repository.dart';
import 'package:rib_reviews/repositories/reviews_repository.dart';
import 'package:rib_reviews/repositories/users_repository.dart';
import 'package:rib_reviews/repositories/venues_repository.dart';

class EventsController with ChangeNotifier {
  final VenuesRepository _venuesRepository;
  final UsersRepository _usersRepository;
  final ReviewsRepository _reviewsRepository;
  final EventsRepository _eventsRepository;

  List<Event> _events = [];
  List<Event> get events => _events;

  EventsController(
    this._venuesRepository,
    this._usersRepository,
    this._reviewsRepository,
    this._eventsRepository,
  );

  void addReview(Review review, Event event) {
    _events.firstWhere((e) => e.id == event.id).reviews.insert(0, review);
    notifyListeners();
  }

  void fetchEvents() async {
    final venues = await _venuesRepository.all();
    final users = await _usersRepository.all();
    final reviews = await _reviewsRepository.all(users);

    _events = await _eventsRepository.all(venues, reviews);

    notifyListeners();
  }
}
