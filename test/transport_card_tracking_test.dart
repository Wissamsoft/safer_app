import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safer_app/core/mock_data.dart';
import 'package:safer_app/core/tracking.dart';

void main() {
  test('Tracking.getAll returns tracked id', () async {
    final t = transports.first;
    SharedPreferences.setMockInitialValues({'track_${t.name}': true});

    final ids = transports.map((t) => t.name).toList();
    final tracked = await Tracking.getAll(ids);

    expect(tracked, contains(t.name));
  });
}
