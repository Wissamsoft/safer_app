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
}
