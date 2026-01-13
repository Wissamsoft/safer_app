import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safer_app/core/mock_data.dart';
import 'package:safer_app/widgets/transport_card.dart';
import 'package:safer_app/screens/trip_detail_screen.dart';

void main() {
  testWidgets('Tapping card opens transport details', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final t = transports.firstWhere((e) => e.image.endsWith('1.jfif'));

    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: TransportCard(transport: t))));
    await tester.pumpAndSettle();

    // Tap on the transport name inside the card to open details
    await tester.tap(find.text(t.name));
    await tester.pumpAndSettle();

    // Expect to find the booking button and tracking button in the detail screen
    expect(find.text('احجز الآن'), findsOneWidget);
    expect(find.text('متابعة'), findsOneWidget);
  });

  testWidgets('Trip detail screen includes tracking action', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: TripDetailScreen(
                title: 'رحلة 1', subtitle: 'من 0 إلى 20 دقيقة'))));
    await tester.pumpAndSettle();

    expect(find.text('رحلة 1'), findsWidgets);
    expect(find.text('متابعة'), findsOneWidget);
  });
}
