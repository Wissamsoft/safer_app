import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  static const _prefix = 'fav_';

  static Future<bool> get(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_prefix + id) ?? false;
    } catch (e, st) {
      debugPrint('Favorites.get failed: $e\n$st');
      return false;
    }
  }

  static Future<void> set(String id, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefix + id, value);
    } catch (e, st) {
      debugPrint('Favorites.set failed: $e\n$st');
    }
  }

  static Future<List<String>> getAll(List<String> ids) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final res = <String>[];
      for (final id in ids) {
        if (prefs.getBool(_prefix + id) == true) {
          res.add(id);
        }
      }
      return res;
    } catch (e, st) {
      debugPrint('Favorites.getAll failed: $e\n$st');
      return <String>[];
    }
  }

  static Future<void> remove(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefix + id);
    } catch (e, st) {
      debugPrint('Favorites.remove failed: $e\n$st');
    }
  }
}
