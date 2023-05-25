import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rib_reviews/domain/models/event.dart';
import 'package:rib_reviews/domain/models/review.dart';
import 'package:rib_reviews/domain/models/user.dart';
import 'package:rib_reviews/domain/models/venue.dart';
import 'package:rib_reviews/data/env/env.dart';
import 'package:rib_reviews/main.dart';
import 'package:rib_reviews/presentation/screens/home_screen.dart';
import 'package:rib_reviews/providers.dart';

final dio = Dio(BaseOptions(baseUrl: Env.apiPath().toString()));
final dioAdapter = DioAdapter(dio: dio);

Widget getHomeScreen() {
  return _buildTree(
    HomeScreen(
      user: User(
          email: 'jordyvanvorselen@gmail.com',
          id: '1',
          photoUrl: null,
          displayName: 'Jordy'),
    ),
  );
}

Widget _buildTree(Widget widget) {
  _initFakeApi();

  return ProviderScope(
    overrides: [Providers.httpClientProvider.overrideWithValue(dio)],
    child: Main(overrideWidget: widget),
  );
}

Venue getVenue(int index) => Venue.fromJson(_mockVenues[index]);
User getUser(int index) => User.fromJson(_mockUsers[index]);
Review getReview(int index) => Review.fromJson(_mockReviews[index], getUser(0));
Event getEvent(int index) => Event.fromJson(_mockEvents[index], getVenue(index),
    _mockReviews.map((r) => Review.fromJson(r, getUser(0))).toList());

final _mockVenues = [
  {
    "_id": "1",
    "location": "Helmond",
    "name": "Mo-Jo",
    "website": "https://mo-jo.eu/en/"
  },
  {
    "_id": "2",
    "location": "Weert",
    "name": "De Slak",
    "website": "https://deslak.com/nederweert/"
  },
  {
    "_id": "3",
    "location": "Eindhoven",
    "name": "Ribs Factory",
    "website": "https://ribsfactory.com/"
  }
];

final _mockReviews = [
  {
    "_id": "1",
    "createdAt": "2023-05-19 14:42:04.994",
    "eventId": "1",
    "rating": 1.5,
    "text": "Erg lekker gegeten.",
    "userId": "1"
  }
];

final _mockEvents = [
  {"_id": "1", "date": "2022-08-11 18:00:00", "venueId": "1"},
  {"_id": "2", "date": null, "venueId": "2"},
  {"_id": "3", "date": "2999-08-11 18:00:00", "venueId": "3"}
];

final _mockUsers = [
  {
    "_id": "1",
    "displayName": "Jordy van Vorselen",
    "email": "jordy.van.vorselen@kabisa.nl",
    "photoUrl": null
  }
];

final _mockReactions = [
  {
    "_id": "1",
    "emoji": "😊",
    "userIds": ["1"],
    "reviewId": "1"
  }
];

final _mockNewReview = {
  "_id": "2",
  "rating": 4.5,
  "text": 'Nice place!',
  "createdAt": "2023-05-19 14:42:04.994",
  "userId": "1",
  "eventId": "1"
};

void _initFakeApi() {
  dioAdapter
    ..onGet('/venues', (server) => server.reply(200, _mockVenues))
    ..onGet('/reviews', (server) => server.reply(200, _mockReviews))
    ..onGet('/events', (server) => server.reply(200, _mockEvents))
    ..onGet('/users', (server) => server.reply(200, _mockUsers))
    ..onGet('/reactions', (server) => server.reply(200, _mockReactions))
    ..onPost(
      '/reviews',
      (server) => server.reply(200, _mockNewReview),
      data: Matchers.any,
    )
    ..onPut(
      '/reactions',
      (server) => server.reply(204, {}),
      data: Matchers.any,
    );
}
