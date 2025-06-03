import 'package:dio/dio.dart';
import 'package:{{app_name}}/core/services/logger/app_logger.dart';
import 'package:{{app_name}}/core/services/storage/token_manager.dart';

class BearerTokenInterceptor extends Interceptor {
  final TokenManager _tokenManager;

  BearerTokenInterceptor(this._tokenManager);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Check if Authorization header already exists
      if (!options.headers.containsKey('Authorization')) {
        final accessToken = await _tokenManager.getAccessToken();

        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
      }
    } catch (e) {
      AppLogger.e('Error getting access token $e');
    }

    handler.next(options);
  }
}
