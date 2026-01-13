import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safer_app/core/mock_data.dart';
import 'package:safer_app/widgets/transport_card.dart';

void main() {
  testWidgets('TransportCard does not overflow on small screen',
      (tester) async {
    SharedPreferences.setMockInitialValues({});

    // small phone size
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;

    final t = transports.firstWhere((e) => e.image.endsWith('1.jfif'));

    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: TransportCard(transport: t))));
    await tester.pumpAndSettle();

    expect(find.byType(TransportCard), findsOneWidget);

    // cleanup
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
