import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safer_app/main.dart';

void main() {
  testWidgets('smoke: named routes exist and build', (tester) async {
    // Use a large test window so full-screen onboarding/other pages layout correctly
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MyApp());

    // Verify core routes are registered by pushing them via Navigator
    final navigator = Navigator.of(tester.element(find.byType(Scaffold)));

    // Named routes that should be reachable without additional args
    final routes = <String>[
      '/onboarding',
      '/home',
      '/payments',
      '/add_card',
      '/payment_success',
      '/profile',
      '/map',
      '/profile_edit',
      '/settings',
      '/help',
      '/favorites',
      '/all_screens',
    ];

    for (final r in routes) {
      // push by name and pop to ensure no exceptions
      navigator.pushNamed(r);
      // avoid waiting for indefinite animations like Lottie — do a short pump
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      navigator.pop();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
    }
  });
}
