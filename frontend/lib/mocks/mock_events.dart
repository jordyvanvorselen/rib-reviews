import '../models/event.dart';
import '../models/venue.dart';

class MockEvents {
  static final data = [
    Event(
      date: null,
      venue: Venue(
          location: "Veldhoven",
          name: "Oakwood",
          website: "http://www.oakwoodgrill.nl/en/"),
    ),
    Event(
      date: DateTime.parse("2023-08-01 18:30:00.000"),
      venue: Venue(
          location: "Eindhoven",
          name: "Ribs Factory",
          website: "https://ribsfactory.com/"),
    ),
    Event(
      date: DateTime.parse("2022-10-01 18:30:00.000"),
      venue: Venue(
          location: "Noord-Stramproy Mooi Spul",
          name: "'t Vosseven Hele Lange Naam",
          website: "https://www.nieuwvosseven.nl/"),
    ),
    Event(
      date: DateTime.parse("2022-09-01 19:00:00.000"),
      venue: Venue(
          location: "Helmond",
          name: "By Onsz",
          website: "https://www.byonsz.nl/"),
    ),
    Event(
      date: DateTime.parse("2022-06-25 20:00:00.000"),
      venue: Venue(
          location: "Weert",
          name: "Denver",
          website: "https://www.denver-restaurants.nl/"),
    ),
  ];
}
