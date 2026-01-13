import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safer_app/core/mock_data.dart';
import 'package:safer_app/widgets/transport_card.dart';

void main() {
  testWidgets('Tapping favorite toggles state and persists', (tester) async {
    // Set mock initial values (empty)
    SharedPreferences.setMockInitialValues({});

    final t = transports.first;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: TransportCard(transport: t)),
    ));

    // Wait for any async init
    await tester.pumpAndSettle();

    // Initially not favorited
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);

    // Tap favorite
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    // Now favorited
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Check persistence
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('fav_${t.name}'), isTrue);

    // Tap to unfavorite
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(prefs.getBool('fav_${t.name}'), isFalse);
  });
}
