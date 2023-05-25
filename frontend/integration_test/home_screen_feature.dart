import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:patrol/patrol.dart';
import 'package:rib_reviews/presentation/components/timeline/event_card.dart';
import 'package:rib_reviews/presentation/components/timeline/event_link.dart';
import 'package:rib_reviews/presentation/components/timeline/timeline.dart';
import 'package:rib_reviews/presentation/screens/review_screen.dart';

import './utils.dart';

void main() {
  patrolTest(
    '''
    Given I am logged in
    When I open the home screen
    Then I see a timeline
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      expect($(Timeline), findsOneWidget);
    },
  );

  patrolTest(
    '''
    Given I am logged in
    And there are 3 events in the database
    When I open the home screen
    And I focus on an unplanned event
    Then I see an eventcard for this event
    And the eventcard contains the name of the event
    And the eventcard contains the location of the event
    And the eventcard shows that the event is not planned yet
    And the eventcard contains a link to the event
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      expect($(EventCard), findsNWidgets(3));

      expect($(EventCard).at(0).$('De Slak'), findsOneWidget);
      expect($(EventCard).at(0).$('Weert'), findsOneWidget);
      expect($(EventCard).at(0).$('Not planned yet'), findsOneWidget);
      expect($(EventCard).at(0).$(EventLink), findsOneWidget);
    },
  );

  patrolTest(
    '''
    Given I am logged in
    And there are 3 events in the database
    When I open the home screen
    And I focus on a planned event
    Then I see an eventcard for this event
    And the eventcard contains the name of the event
    And the eventcard contains the location of the event
    And the eventcard contains the date that the event will be held
    And the eventcard contains the time that the event will find place
    And the eventcard contains a link to the event
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      expect($(EventCard), findsNWidgets(3));

      expect($(EventCard).at(1).$('Ribs Factory'), findsOneWidget);
      expect($(EventCard).at(1).$('Eindhoven'), findsOneWidget);
      expect($(EventCard).at(1).$('August 11, 2999'), findsOneWidget);
      expect($(EventCard).at(1).$('18:00:00'), findsOneWidget);
      expect($(EventCard).at(1).$(EventLink), findsOneWidget);
    },
  );

  patrolTest(
    '''
    Given I am logged in
    And there are 3 events in the database
    When I open the home screen
    And I focus on a finished event
    Then I see an eventcard for this event
    And the eventcard contains the name of the event
    And the eventcard contains the location of the event
    And the eventcard contains how many reviews the event has
    And the eventcard contains the rating of the event
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      expect($(EventCard), findsNWidgets(3));

      expect($(EventCard).at(2).$('Mo-Jo'), findsOneWidget);
      expect($(EventCard).at(2).$('Helmond'), findsOneWidget);
      expect($(EventCard).at(2).$('1 reviews'), findsOneWidget);
      expect($(EventCard).at(2).$('1.5'), findsOneWidget);
    },
  );

  patrolTest(
    '''
    Given I am logged in
    When I open the home screen
    And I click the timeline tile of a finished event
    Then I navigate to the review screen
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      await $(EventCard).at(2).tap(andSettle: true);

      expect($(ReviewScreen), findsOneWidget);
    },
  );
}
