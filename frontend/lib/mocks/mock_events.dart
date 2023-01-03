import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';

import '../models/event.dart';
import '../models/venue.dart';

class MockEvents {
  static final users = [
    User(
      email: "jordyvanvorselen@gmail.com",
      photoUrl:
          "https://www.gravatar.com/avatar/34115e78381276eaf43a2359e243359f",
      displayName: "Jordy van Vorselen",
    ),
    User(
      email: "t0x1cjor@hotmail.com",
      photoUrl:
          "https://www.gravatar.com/avatar/ba66d76e9649604db71ecd651463e3ce",
      displayName: "Another Kek",
    ),
  ];

  static final reviews = [
    Review(
      rating: 4.5,
      text: "Wat een geweldig restaurant. Hier wil ik nog eens naartoe!",
      user: users[0],
    ),
    Review(
      rating: 2,
      text: "Dit was echt niks.",
      user: users[1],
    ),
  ];

  static final data = [
    Event(
      date: null,
      venue: Venue(
        location: "Veldhoven",
        name: "Oakwood",
        website: "http://www.oakwoodgrill.nl/en/",
      ),
      reviews: [],
    ),
    Event(
      date: DateTime.parse("2023-08-01 18:30:00.000"),
      venue: Venue(
        location: "Eindhoven",
        name: "Ribs Factory",
        website: "https://ribsfactory.com/",
      ),
      reviews: [],
    ),
    Event(
      date: DateTime.parse("2022-10-01 18:30:00.000"),
      venue: Venue(
        location: "Noord-Stramproy",
        name: "'t Vosseven",
        website: "https://www.nieuwvosseven.nl/",
      ),
      reviews: reviews,
    ),
    Event(
      date: DateTime.parse("2022-09-01 19:00:00.000"),
      venue: Venue(
        location: "Helmond",
        name: "By Onsz",
        website: "https://www.byonsz.nl/",
      ),
      reviews: reviews,
    ),
    Event(
      date: DateTime.parse("2022-06-25 20:00:00.000"),
      venue: Venue(
        location: "Weert",
        name: "Denver",
        website: "https://www.denver-restaurants.nl/",
      ),
      reviews: [],
    ),
  ];
}
