import 'dart:convert';
import 'package:{{app_name}}/core/services/storage/local_storage_service.dart';
import 'package:{{app_name}}/domain/models/user.dart';

class UserManager {
  static const _userKey = 'user_data';
  final LocalStorageService _storage;

  UserManager({required LocalStorageService storage}) : _storage = storage;

  Future<void> saveUser(User user) async {
    final userMap = user.toMap();
    final userJson = jsonEncode(userMap);
    await _storage.write<String>(key: _userKey, value: userJson);
  }

  Future<User?> getUser() async {
    final userJson = await _storage.read<String>(key: _userKey);
    if (userJson == null) return null;

    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    return User.fromMap(userMap);
  }

  Future<void> clearUserData() async {
    await _storage.delete(key: _userKey);
  }
}
