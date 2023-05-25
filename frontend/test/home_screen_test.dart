import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rib_reviews/domain/models/user.dart';
import 'package:rib_reviews/presentation/components/timeline/timeline.dart';
import 'package:rib_reviews/presentation/screens/home_screen.dart';

void main() {
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
