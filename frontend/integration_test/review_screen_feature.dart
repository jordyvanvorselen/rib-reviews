import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:patrol/patrol.dart';
import 'package:rib_reviews/components/event_card.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/components/review_screen_title.dart';

import './utils.dart';

void main() {
  patrolTest(
    '''
    Given I am logged in
    When I am on the review screen
    Then I see the venue name
    And I see the venue location
    And I see the star rating of the event
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      await $(EventCard).at(2).tap(andSettle: true);

      expect($('Mo-Jo'), findsOneWidget);
      expect($('Helmond'), findsOneWidget);

      expect($('1.5'), findsOneWidget);
      expect($(Rating), findsNWidgets(2));
    },
  );

  patrolTest(
    '''
    Given I am logged in
    When I am on the review screen
    Then I see all reviews
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      await $(EventCard).at(2).tap(andSettle: true);

      expect($(ReviewScreenTitle), findsOneWidget);
      expect($('Erg lekker gegeten.'), findsOneWidget);
    },
  );

  patrolTest(
    '''
    Given I am logged in
    And I am on the review screen
    When I click the floating action button
    Then I see a popup that allows me to create a new review
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      await $(EventCard).at(2).tap(andSettle: true);

      expect($(FloatingActionButton), findsOneWidget);

      await $(FloatingActionButton).tap(andSettle: true);

      expect($(AlertDialog), findsOneWidget);
    },
  );
}
