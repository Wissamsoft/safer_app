import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tracking {
  static const _prefix = 'track_';

  static Future<bool> isTracking(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_prefix + id) ?? false;
    } catch (e, st) {
      debugPrint('Tracking.isTracking failed: $e\n$st');
      return false;
    }
  }

  static Future<void> setTracking(String id, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefix + id, value);
    } catch (e, st) {
      debugPrint('Tracking.setTracking failed: $e\n$st');
    }
  }

  static Future<List<String>> getAll(List<String> ids) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final res = <String>[];
      for (final id in ids) {
        if (prefs.getBool(_prefix + id) == true) res.add(id);
      }
      return res;
    } catch (e, st) {
      debugPrint('Tracking.getAll failed: $e\n$st');
      return <String>[];
    }
  }

  static Future<void> remove(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefix + id);
    } catch (e, st) {
      debugPrint('Tracking.remove failed: $e\n$st');
    }
  }
}
