import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static late SharedPreferences _prefs;

  static const _isLoggedInKey = 'isLoggedIn';
  static const _bookmarksKey = 'bookmarkedArticles';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Login status
  static bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_isLoggedInKey, value);
  }

  // Bookmarks
  static List<String> getBookmarks() {
    return _prefs.getStringList(_bookmarksKey) ?? [];
  }

  static Future<void> saveBookmark(Map<String, dynamic> article) async {
    final List<String> current = getBookmarks();
    current.add(jsonEncode(article));
    await _prefs.setStringList(_bookmarksKey, current);
  }

  static Future<void> removeBookmark(String url) async {
    final List<String> current = getBookmarks();
    current.removeWhere((item) => jsonDecode(item)['url'] == url);
    await _prefs.setStringList(_bookmarksKey, current);
  }

  static Future<void> clearBookmarks() async {
    await _prefs.remove(_bookmarksKey);
  }
}
