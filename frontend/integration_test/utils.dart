import 'package:rib_reviews/main.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rib_reviews/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rib_reviews/env/env.dart';

final dio = Dio(BaseOptions(baseUrl: Env.apiPath().toString()));
final dioAdapter = DioAdapter(dio: dio);

Widget buildTree(Widget widget) {
  _initFakeApi();

  return ProviderScope(
    child: Main(overrideWidget: widget),
    overrides: [Providers.httpClientProvider.overrideWithValue(dio)],
  );
}

final mockVenues = [
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

final mockReviews = [
  {
    "_id": "1",
    "createdAt": "2023-05-19 14:42:04.994",
    "eventId": "1",
    "rating": 1.5,
    "text": "Test",
    "userId": "1"
  }
];

final mockEvents = [
  {"_id": "1", "date": "2022-08-11 18:00:00", "venueId": "1"},
  {"_id": "2", "date": null, "venueId": "2"},
  {"_id": "3", "date": "2999-08-11 18:00:00", "venueId": "3"}
];

final mockUsers = [
  {
    "_id": "1",
    "displayName": "Jordy van Vorselen",
    "email": "jordy.van.vorselen@kabisa.nl",
    "photoUrl": null
  }
];

void _initFakeApi() {
  dioAdapter
    ..onGet('/venues', (server) => server.reply(200, mockVenues))
    ..onGet('/reviews', (server) => server.reply(200, mockReviews))
    ..onGet('/events', (server) => server.reply(200, mockEvents))
    ..onGet('/users', (server) => server.reply(200, mockUsers));
}
