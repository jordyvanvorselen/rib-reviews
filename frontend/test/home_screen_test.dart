import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:nock/nock.dart';
import 'package:rib_reviews/components/timeline.dart';
import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/screens/home_screen.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();

    nock(Env.apiPath('').toString()).get("/reviews").reply(200, {
      "_id": "64676e9df0b84b117b931a5e",
      "createdAt": "2023-05-19 14:42:04.994",
      "eventId": "6466a0b727a0003176e0947e",
      "rating": 1.5,
      "text": "Test",
      "userId": "6466a3e1cc028c17955bf21e"
    });
  });

  testWidgets('renders a timeline', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await mockNetworkImagesFor(
      () async => await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: HomeScreen(
              user: User(
                email: 'jordyvanvorselen@gmail.com',
                id: '1',
                photoUrl: null,
                displayName: 'Jordy',
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(Timeline), findsOneWidget);
  });
}
