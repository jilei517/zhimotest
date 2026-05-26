import 'package:flutter/material.dart';

class BlockedUsersProvider extends ChangeNotifier {
  final Set<String> _blockedUsers = {};
  final Set<String> _mutedUsers = {};
  final List<Map<String, dynamic>> _reports = [];

  Set<String> get blockedUsers => _blockedUsers;
  Set<String> get mutedUsers => _mutedUsers;
  List<Map<String, dynamic>> get reports => _reports;

  void blockUser(String userName) {
    _blockedUsers.add(userName);
    // 拉黑时自动移除屏蔽
    _mutedUsers.remove(userName);
    notifyListeners();
  }

  void muteUser(String userName) {
    _mutedUsers.add(userName);
    notifyListeners();
  }

  void unblockUser(String userName) {
    _blockedUsers.remove(userName);
    notifyListeners();
  }

  void unmuteUser(String userName) {
    _mutedUsers.remove(userName);
    notifyListeners();
  }

  void submitReport({
    required String contentType,
    required String contentId,
    required String userName,
    required String reason,
    required String description,
    required List<String> imageUrls,
  }) {
    _reports.add({
      'contentType': contentType,
      'contentId': contentId,
      'userName': userName,
      'reason': reason,
      'description': description,
      'imageUrls': imageUrls,
      'timestamp': DateTime.now(),
      'status': 'pending', // pending, reviewing, resolved
    });
    notifyListeners();
  }

  bool isUserBlocked(String userName) {
    return _blockedUsers.contains(userName);
  }

  bool isUserMuted(String userName) {
    return _mutedUsers.contains(userName);
  }

  bool shouldFilterUser(String userName) {
    return _blockedUsers.contains(userName) || _mutedUsers.contains(userName);
  }

  int getBlockedUsersCount() {
    return _blockedUsers.length;
  }

  int getMutedUsersCount() {
    return _mutedUsers.length;
  }

  int getReportsCount() {
    return _reports.length;
  }
}
