import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:rib_reviews/main.dart';

void main() {
  patrolTest(
    '''
    Given I am not logged in
    When I open the login screen
    Then I want to see the logo
    ''',
    (PatrolTester $) async {
      await $.pumpWidgetAndSettle(const Main());

      expect($(Image), findsOneWidget);
    },
  );

  patrolTest(
    '''
    Given I am not logged in
    When I open the login screen
    Then I want to see the title of the app
    ''',
    (PatrolTester $) async {
      await $.pumpWidgetAndSettle(const Main());

      expect($('Welcome to'), findsWidgets);
      expect($('The Eat Guildt'), findsWidgets);
    },
  );
}
