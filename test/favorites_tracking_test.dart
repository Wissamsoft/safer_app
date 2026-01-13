import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safer_app/core/mock_data.dart';
import 'package:safer_app/core/favorites_safe.dart';
import 'package:safer_app/core/tracking.dart';

void main() {
  test('Favorites and Tracking return correct ids', () async {
    final t = transports.first;
    SharedPreferences.setMockInitialValues({
      'fav_${t.name}': true,
      'track_${t.name}': true,
    });

    final ids = transports.map((t) => t.name).toList();
    final favIds = await Favorites.getAll(ids);
    final tracked = await Tracking.getAll(ids);

    expect(favIds, contains(t.name));
    expect(tracked, contains(t.name));
  });
}
