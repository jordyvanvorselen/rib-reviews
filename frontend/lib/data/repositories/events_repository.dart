import 'package:rib_reviews/data/api.dart';
import 'package:rib_reviews/domain/models/review.dart';
import 'package:rib_reviews/domain/models/venue.dart';

import '../../domain/models/event.dart';

class EventsRepository {
  API apiClient;

  EventsRepository({required this.apiClient});

  Future<List<Event>> all(List<Venue> venues, List<Review> reviews) async {
    try {
      final eventsResponse =
          (await apiClient.get('/events').run()).getOrElse((l) => throw l);

      List<Event> events = eventsResponse.data
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
