import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rib_reviews/components/timeline.dart';
import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/providers/providers.dart';
import 'package:timeline_tile/timeline_tile.dart';

void main() {
  final dio = Dio(BaseOptions(baseUrl: Env.apiPath().toString()));
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter
    ..onGet(
      '/venues',
      (server) => server.reply(
        200,
        [
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
          }
        ],
        delay: const Duration(seconds: 1),
      ),
    )
    ..onGet(
      '/reviews',
      (server) => server.reply(
        200,
        [
          {
            "_id": "1",
            "createdAt": "2023-05-19 14:42:04.994",
            "eventId": "1",
            "rating": 1.5,
            "text": "Test",
            "userId": "1"
          },
          {
            "_id": "2",
            "createdAt": "2023-05-19 12:40:00.000",
            "eventId": "2",
            "rating": 1.5,
            "text": "Test",
            "userId": "1"
          }
        ],
        delay: const Duration(seconds: 1),
      ),
    )
    ..onGet(
      '/events',
      (server) => server.reply(
        200,
        [
          {"_id": "1", "date": "2022-08-11 18:00:00", "venueId": "1"},
          {"_id": "2", "date": "2024-08-11 18:00:00", "venueId": "2"}
        ],
        delay: const Duration(seconds: 1),
      ),
    )
    ..onGet(
      '/users',
      (server) => server.reply(
        200,
        [
          {
            "_id": "1",
            "displayName": "Jordy van Vorselen",
            "email": "jordy.van.vorselen@kabisa.nl",
            "photoUrl":
                "https://lh3.googleusercontent.com/a/AGNmyxb2leu0Zt91Fx8M80myLas7B6YwdyICzTrm1uIo=s96-c"
          }
        ],
        delay: const Duration(seconds: 1),
      ),
    );

  testWidgets('renders time line tiles', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await mockNetworkImagesFor(
      () async => await tester.pumpWidget(
        ProviderScope(
          overrides: [Providers.httpClientProvider.overrideWithValue(dio)],
          child: MaterialApp(
            home: Column(
              children: [
                Timeline(
                  user: User(
                    email: 'jordy.van.vorselen@kabisa.nl',
                    id: '1',
                    photoUrl:
                        "https://lh3.googleusercontent.com/a/AGNmyxb2leu0Zt91Fx8M80myLas7B6YwdyICzTrm1uIo=s96-c",
                    displayName: 'Jordy van Vorselen',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    debugDumpApp();

    expect(find.byType(TimelineTile), findsOneWidget);
  });
}
