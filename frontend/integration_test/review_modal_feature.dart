import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:rib_reviews/screens/review_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/components/review_screen_title.dart';
import 'package:rib_reviews/components/rating.dart';
import 'package:rib_reviews/components/event_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rib_reviews/screens/home_screen.dart';
import './utils.dart';

void main() {
  final reviewScreen =
      buildTree(ReviewScreen(event: getEvent(0), user: getUser(0)));

  patrolTest(
    '''
    Given I am logged in
    And I have the create review modal open
    When I press the cancel button
    Then the modal closes
    ''',
    (PatrolTester $) async {
      await mockNetworkImagesFor(
        () async => await $.pumpWidgetAndSettle(reviewScreen),
      );

      expect($(FloatingActionButton), findsOneWidget);

      await $(FloatingActionButton).tap(andSettle: true);

      expect($(AlertDialog), findsOneWidget);

      await $(DialogButton).$('Cancel').tap(andSettle: true);

      expect($(AlertDialog), findsNothing);
    },
  );

  final homeScreen = buildTree(
    HomeScreen(
      user: User(
          email: 'jordyvanvorselen@gmail.com',
          id: '1',
          photoUrl: null,
          displayName: 'Jordy'),
    ),
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
        () async => await $.pumpWidgetAndSettle(homeScreen),
      );

      await $(EventCard).at(2).tap(andSettle: true);

      expect($(FloatingActionButton), findsOneWidget);

      await $(FloatingActionButton).tap(andSettle: true);

      expect($(AlertDialog).$('Leave a review'), findsOneWidget);
      expect($(AlertDialog).$('How was your time at Mo-Jo?'), findsOneWidget);
      expect($(AlertDialog).$(Rating), findsOneWidget);
      expect($(AlertDialog).$(TextField), findsOneWidget);

      await $(AlertDialog).$(Rating).$(Icons.star).at(4).tap(andSettle: true);
      await $(AlertDialog).$(TextField).enterText('Nice place!');

      await $(DialogButton).$('Save').tap(andSettle: true);

      expect($(AlertDialog), findsNothing);
      expect($('Nice place!'), findsOneWidget);
    },
  );
}
