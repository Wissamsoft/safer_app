import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safer_app/widgets/transport_card.dart';
import 'package:safer_app/screens/transport_detail_screen.dart';
import 'package:safer_app/core/mock_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestAssetBundle extends CachingAssetBundle {
  final Uint8List data;
  _TestAssetBundle(this.data);
  @override
  Future<ByteData> load(String key) async => ByteData.view(data.buffer);

  @override
  Future<T> loadStructuredBinaryData<T>(
      String key, FutureOr<T> Function(ByteData) parser) async {
    // Return a binary-encoded (StandardMessageCodec) empty asset manifest so
    // the AssetManifest loader can parse it as binary without errors.
    final encoded =
        const StandardMessageCodec().encodeMessage(<String, List<String>>{});
    if (encoded == null) {
      return await parser(ByteData.view(Uint8List.fromList([]).buffer));
    }
    final bd = encoded;
    return await parser(bd);
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, FutureOr<T> Function(String) parser) async {
    return await parser('{}');
  }
}

void main() {
  testWidgets('open detail, toggle tracking, return and card updates',
      (tester) async {
    final t = transports.first;
    // Start with not tracked
    SharedPreferences.setMockInitialValues({'track_${t.name}': false});

    // Make window large enough so buttons are reachable in tests
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final pngBase64 =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII=';
    final bytes = base64Decode(pngBase64);

    await tester.pumpWidget(MaterialApp(
      home: DefaultAssetBundle(
          bundle: _TestAssetBundle(bytes),
          child: Scaffold(body: TransportCard(transport: t))),
    ));

    await tester.pumpAndSettle();

    // Initially no 'متابع' in card
    expect(find.text('متابع'), findsNothing);

    // Open detail
    await tester.tap(find.byType(TransportCard));
    await tester.pumpAndSettle();

    // We should be on detail screen
    expect(find.byType(TransportDetailScreen), findsOneWidget);

    // Tap the follow button (Outlined 'متابعة')
    await tester.ensureVisible(find.text('متابعة'));
    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();

    // Button should now read 'متابع'
    expect(find.text('متابع'), findsOneWidget);

    // Pop back (use arrow back icon)
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Card should now show tracked label (animated switcher might delay)
    await tester.pumpAndSettle(const Duration(milliseconds: 300));
    expect(find.text('متابع'), findsOneWidget);
  });
}
