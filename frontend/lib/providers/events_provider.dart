import 'package:flutter/material.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/repositories/events_repository.dart';
import 'package:rib_reviews/repositories/reviews_repository.dart';
import 'package:rib_reviews/repositories/users_repository.dart';
import 'package:rib_reviews/repositories/venues_repository.dart';

class EventsProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  void addReview(Review review, Event event) {
    _events.firstWhere((e) => e.id == event.id).reviews.insert(0, review);
    notifyListeners();
  }

  void fetchEvents() async {
    final venues = await VenuesRepository.all();
    final users = await UsersRepository.all();
    final reviews = await ReviewsRepository.all(users);

    _events = await EventsRepository.all(venues, reviews);

    notifyListeners();
  }
}
