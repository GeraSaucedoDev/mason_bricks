import 'package:{{app_name}}/core/services/storage/secure_storage_service.dart';

/// Manages the storage and retrieval of authentication tokens
/// using a secure storage service.
///
/// This class handles access tokens, refresh tokens, and API keys,
/// providing methods to get, save, and clear these tokens as needed.
class TokenManager {
  final SecureStorageService _storageService;
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _apiKey = 'api_key';

  /// Constructor that initializes the TokenManager with a secure storage service.
  TokenManager(this._storageService);

  /// Retrieves the access token from secure storage.
  /// Returns the token as a String if it exists, or null if not.
  Future<String?> getAccessToken() async {
    return await _storageService.read<String>(key: _accessTokenKey);
  }

  /// Retrieves the refresh token from secure storage.
  /// Returns the token as a String if it exists, or null if not.
  Future<String?> getRefreshToken() async {
    return await _storageService.read<String>(key: _refreshTokenKey);
  }

  /// Retrieves the API key from secure storage.
  /// Returns the key as a String if it exists, or null if not.
  Future<String?> getApiKey() async {
    return await _storageService.read<String>(key: _apiKey);
  }

  /// Saves the access token to secure storage.
  ///
  /// If the provided token is empty, it does not perform any action.
  Future<void> saveAccessToken(String token) async {
    if (token.isEmpty) return; // Prevent saving empty tokens
    await _storageService.write<String>(key: _accessTokenKey, value: token);
  }

  /// Saves the refresh token to secure storage.
  ///
  /// If the provided token is empty, it does not perform any action.
  Future<void> saveRefreshToken(String token) async {
    if (token.isEmpty) return; // Prevent saving empty tokens
    await _storageService.write<String>(key: _refreshTokenKey, value: token);
  }

  /// Saves the API key to secure storage.
  ///
  /// If the provided token is empty, it does not perform any action.
  Future<void> saveApiKey(String token) async {
    if (token.isEmpty) return; // Prevent saving empty tokens
    await _storageService.write<String>(key: _apiKey, value: token);
  }

  /// Clears all stored tokens from secure storage.
  Future<void> clearTokens() async {
    await _storageService.delete(key: _accessTokenKey);
    await _storageService.delete(key: _refreshTokenKey);
    await _storageService.delete(key: _apiKey);
  }
}
