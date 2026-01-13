import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safer_app/screens/trip_detail_screen.dart';
import 'package:safer_app/core/tracking.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('tracking toggle persists and updates UI', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
        MaterialApp(home: TripDetailScreen(title: 'Trip A', subtitle: 'Sub')));

    expect(find.text('متابعة'), findsOneWidget);

    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();

    expect(find.text('متابع'), findsOneWidget);

    final isTracking = await Tracking.isTracking('Trip A');
    expect(isTracking, isTrue);

    // Toggle off
    await tester.tap(find.text('متابع'));
    await tester.pumpAndSettle();

    expect(find.text('متابعة'), findsOneWidget);
    final isTracking2 = await Tracking.isTracking('Trip A');
    expect(isTracking2, isFalse);
  });
}
