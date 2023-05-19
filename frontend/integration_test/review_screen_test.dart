import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:rib_reviews/screens/review_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/venue.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/components/review_screen_title.dart';
import './utils.dart';

void main() {
  final user = User.fromJson(mockUsers[0]);
  final venue = Venue.fromJson(mockVenues[0]);
  final review = Review.fromJson(mockReviews[0], user);
  final event = Event.fromJson(mockEvents[0], venue, [review]);

  final widget = buildTree(ReviewScreen(event: event, user: user));

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
