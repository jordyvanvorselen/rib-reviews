import 'package:flutter/material.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/repositories/events_repository.dart';

class EventsProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  void addReview(Review review, Event event) {
    _events.firstWhere((e) => e.id == event.id).reviews.add(review);
    notifyListeners();
  }

  void fetchEvents() async {
    _events = await EventsRepository.getEvents();
    notifyListeners();
  }
}
