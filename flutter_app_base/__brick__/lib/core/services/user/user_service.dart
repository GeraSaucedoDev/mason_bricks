import 'dart:convert';

import 'package:{{app_name}}/core/services/api/api_client.dart';
import 'package:{{app_name}}/core/services/storage/local_storage_service.dart';
import 'package:{{app_name}}/domain/models/user.dart';

import '../logger/app_logger.dart';

class UserService {
  UserService(
      {required ApiClient apiClient, required LocalStorageService storage})
      : //_apiClient = apiClient,
        _storage = storage,
        super();

  //final ApiClient _apiClient;
  final LocalStorageService _storage;
  static const _userKey = 'user_data';

  Future<User> getUserData(String accessToken) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final hardCodeUserData = {
        "firstName": "Daniel",
        "lastName": "León",
        "email": "daniel.leon@example.com",
        "username": "danieleon",
        "birthdate": "2002-03-26",
      };

      final user = User.fromJson(json.encode(hardCodeUserData));
      return user;

      /*
    final result = await _apiClient.get(
      'url_link',
    );

    final user = User.fromJson(result.data);
    return user;

    */
    } catch (e) {
      AppLogger.e('UserService | getUserData(): \n\n$e');
      rethrow;
    }
  }

  Future<void> clearUserData() async {
    await _storage.delete(key: _userKey);
  }
}
