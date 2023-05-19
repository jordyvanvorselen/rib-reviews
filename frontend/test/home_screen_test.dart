import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rib_reviews/components/timeline.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/screens/home_screen.dart';

void main() {
  testWidgets('renders a timeline', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(
        user: User(
          email: 'jordyvanvorselen@gmail.com',
          id: '1',
          photoUrl: null,
          displayName: 'Jordy',
        ),
      ),
    ));

    await tester.pumpAndSettle();

    debugDumpApp();

    expect(find.byType(Timeline), findsOneWidget);
  });
}
