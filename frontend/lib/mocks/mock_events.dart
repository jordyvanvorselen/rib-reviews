import '../models/event.dart';
import '../models/venue.dart';

class MockEvents {
  static final data = [
    Event(
      date: DateTime.parse("2023-08-01 18:30:00.000"),
      venue: Venue(location: "Eindhoven", name: "Ribs Factory"),
    ),
    Event(
      date: DateTime.parse("2022-10-01 18:30:00.000"),
      venue: Venue(location: "Noord-Stramproy", name: "'t Vosseven"),
    ),
    Event(
      date: DateTime.parse("2022-09-01 19:00:00.000"),
      venue: Venue(location: "Helmond", name: "By Onsz"),
    ),
    Event(
      date: DateTime.parse("2022-06-25 20:00:00.000"),
      venue: Venue(location: "Weert", name: "Denver"),
    ),
  ];
}
