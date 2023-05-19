import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:rib_reviews/screens/review_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rib_reviews/components/review_screen_title.dart';
import './utils.dart';

void main() {
  final widget = buildTree(ReviewScreen(event: getEvent(0), user: getUser(0)));

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
    },
  );
}
