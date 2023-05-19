import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:rib_reviews/screens/review_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rib_reviews/components/review_screen_title.dart';
import 'package:rib_reviews/components/rating.dart';
import './utils.dart';

void main() {
  final widget = buildTree(ReviewScreen(event: getEvent(0), user: getUser(0)));

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
        () async => await $.pumpWidgetAndSettle(widget),
      );

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
        () async => await $.pumpWidgetAndSettle(widget),
      );

      expect($(ReviewScreenTitle), findsOneWidget);
      expect($('Erg lekker gegeten.'), findsOneWidget);
    },
  );
}
