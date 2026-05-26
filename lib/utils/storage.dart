import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  // 每次按需获取实例，不依赖 init() 调用
  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  // User preferences
  static Future<void> saveUserName(String name) async {
    final prefs = await _prefs;
    await prefs.setString('user_name', name);
  }

  static Future<String?> getUserName() async {
    final prefs = await _prefs;
    return prefs.getString('user_name');
  }

  static Future<void> saveUserBio(String bio) async {
    final prefs = await _prefs;
    await prefs.setString('user_bio', bio);
  }

  static Future<String?> getUserBio() async {
    final prefs = await _prefs;
    return prefs.getString('user_bio');
  }

  // Activities
  static Future<void> saveLikedActivities(List<String> ids) async {
    final prefs = await _prefs;
    await prefs.setStringList('liked_activities', ids);
  }

  static Future<List<String>> getLikedActivities() async {
    final prefs = await _prefs;
    return prefs.getStringList('liked_activities') ?? [];
  }

  static Future<void> addLikedActivity(String id) async {
    final liked = await getLikedActivities();
    if (!liked.contains(id)) {
      liked.add(id);
      await saveLikedActivities(liked);
    }
  }

  static Future<void> removeLikedActivity(String id) async {
    final liked = await getLikedActivities();
    liked.remove(id);
    await saveLikedActivities(liked);
  }

  // Feeds
  static Future<void> saveLikedFeeds(List<String> ids) async {
    final prefs = await _prefs;
    await prefs.setStringList('liked_feeds', ids);
  }

  static Future<List<String>> getLikedFeeds() async {
    final prefs = await _prefs;
    return prefs.getStringList('liked_feeds') ?? [];
  }

  static Future<void> addLikedFeed(String id) async {
    final liked = await getLikedFeeds();
    if (!liked.contains(id)) {
      liked.add(id);
      await saveLikedFeeds(liked);
    }
  }

  static Future<void> removeLikedFeed(String id) async {
    final liked = await getLikedFeeds();
    liked.remove(id);
    await saveLikedFeeds(liked);
  }

  // Clear all
  static Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
