import 'package:flutter/material.dart';
import 'package:shandada/models/user.dart';
import 'package:shandada/constants/mock_data.dart';
import 'package:shandada/utils/storage.dart';

class UserProvider extends ChangeNotifier {
  late User _currentUser;

  UserProvider() {
    _currentUser = MockData.currentUser;
  }

  User get currentUser => _currentUser;

  void updateUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void updateUserName(String name) {
    _currentUser = _currentUser.copyWith(name: name);
    notifyListeners();
  }

  void updateUserAvatar(String avatar) {
    _currentUser = _currentUser.copyWith(avatar: avatar);
    notifyListeners();
  }

  void updateUserGender(String gender) {
    _currentUser = _currentUser.copyWith(gender: gender);
    notifyListeners();
  }

  void updateUserAge(int age) {
    _currentUser = _currentUser.copyWith(age: age);
    notifyListeners();
  }

  void updateUserInterests(List<String> interests) {
    _currentUser = _currentUser.copyWith(interests: interests);
    notifyListeners();
  }

  void updateUserMBTI(String mbti) {
    _currentUser = _currentUser.copyWith(mbti: mbti);
    notifyListeners();
  }

  void updateUserSignature(String signature) {
    _currentUser = _currentUser.copyWith(signature: signature);
    notifyListeners();
  }

  /// 注销账号：清除本地所有数据并重置用户状态
  Future<void> deleteAccount() async {
    await StorageUtil.clearAll();
    _currentUser = MockData.currentUser;
    notifyListeners();
  }
}
