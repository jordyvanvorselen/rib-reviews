import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:rib_reviews/main.dart';
import 'package:rib_reviews/screens/home_screen.dart';
import 'package:rib_reviews/components/timeline.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rib_reviews/providers/providers.dart';
import 'package:rib_reviews/env/env.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:timeline_tile/timeline_tile.dart';
import './utils.dart';

final dio = Dio(BaseOptions(baseUrl: Env.apiPath().toString()));
final dioAdapter = DioAdapter(dio: dio);

final widget = ProviderScope(
  child: Main(
    overrideWidget: HomeScreen(
      user: User(
        email: 'jordyvanvorselen@gmail.com',
        id: '1',
        photoUrl: null,
        displayName: 'Jordy',
      ),
    ),
  ),
  overrides: [Providers.httpClientProvider.overrideWithValue(dio)],
);

void main() {
  setUp(() {
    initFakeApi(dioAdapter);
  });

  patrolTest(
    '''
    Given I am logged in
    When I open the home screen
    Then I want to see a timeline
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(widget),
      );

      expect($(Timeline), findsOneWidget);
    },
  );

  patrolTest(
    '''
    Given I am logged in
    And there are 2 events in the database
    When I open the home screen
    Then I want to see a timeline tile for each event
    And I want to see the name of each event
    And I want to see the location of each event
    And I want to see how many reviews an event has
    And I want to see the rating of the event
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(widget),
      );

      expect($(TimelineTile), findsNWidgets(2));

      expect($('Mo-Jo'), findsOneWidget);
      expect($('De Slak'), findsOneWidget);

      expect($('Helmond'), findsOneWidget);
      expect($('Weert'), findsOneWidget);

      expect($('1 reviews'), findsOneWidget);
      expect($('1.5'), findsOneWidget);
    },
  );
}
