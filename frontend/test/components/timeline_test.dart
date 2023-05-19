import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rib_reviews/components/timeline.dart';
import 'package:rib_reviews/env/env.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:timeline_tile/timeline_tile.dart';

void main() {
  testWidgets('renders time line tiles', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await mockNetworkImagesFor(
      () async => await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Container(
              child: Timeline(
                user: User(
                  email: 'jordy.van.vorselen@kabisa.nl',
                  id: '6466a3e1cc028c17955bf21e',
                  photoUrl:
                      "https://lh3.googleusercontent.com/a/AGNmyxb2leu0Zt91Fx8M80myLas7B6YwdyICzTrm1uIo=s96-c",
                  displayName: 'Jordy van Vorselen',
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await pumpEventQueue();

    expect(find.byType(TimelineTile), findsOneWidget);
  });
}
