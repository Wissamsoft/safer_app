import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  static const _prefix = 'fav_';

  static Future<bool> get(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefix + id) ?? false;
  }

  static Future<void> set(String id, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefix + id, value);
  }

  /// Return a list of ids that are favorited among the provided ids list.
  static Future<List<String>> getAll(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final res = <String>[];
    for (final id in ids) {
      if (prefs.getBool(_prefix + id) == true) {
        res.add(id);
      }
    }
    return res;
  }

  /// Remove a favorite by id
  static Future<void> remove(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefix + id);
  }
}
