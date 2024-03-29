import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:patrol/patrol.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rib_reviews/presentation/components/generic/rating.dart';
import 'package:rib_reviews/presentation/components/timeline/event_card.dart';

import './utils.dart';

void main() {
  patrolTest(
    '''
    Given I am logged in
    And I have the create review modal open
    When I press the cancel button
    Then the modal closes
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      await $(EventCard).at(2).tap(andSettle: true);

      expect($(FloatingActionButton), findsOneWidget);

      await $(FloatingActionButton).tap(andSettle: true);

      expect($(AlertDialog), findsOneWidget);

      await $(DialogButton).$('Cancel').tap(andSettle: true);

      expect($(AlertDialog), findsNothing);
    },
  );

  patrolTest(
    '''
    Given I am logged in
    When I open the create review modal
    Then I see a title in the modal
    And I see a subtitle
    And I can rate the event
    And I can fill in my review text
    When I save the review
    Then the modal closes
    And I see the new review
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(getHomeScreen()),
      );

      await $(EventCard).at(2).tap(andSettle: true);

      expect($(FloatingActionButton), findsOneWidget);

      await $(FloatingActionButton).tap(andSettle: true);

      expect($(AlertDialog).$('Leave a review'), findsOneWidget);
      expect($(AlertDialog).$('How was your time at Mo-Jo?'), findsOneWidget);
      expect($(AlertDialog).$(Rating), findsOneWidget);
      expect($(AlertDialog).$(TextField), findsOneWidget);

      await $(AlertDialog).$(Rating).$(Icons.star).at(4).tap(andSettle: true);
      await $(AlertDialog)
          .$(TextField)
          .enterText('Nice place!', andSettle: true);

      await $(DialogButton).$('Save').tap(andSettle: true);

      expect($(AlertDialog), findsNothing);
      expect($('Nice place!'), findsOneWidget);
    },
  );
}
