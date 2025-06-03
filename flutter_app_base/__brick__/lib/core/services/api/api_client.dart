import 'package:dio/dio.dart';
import 'package:{{app_name}}/core/services/api/interceptor_bearer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:{{app_name}}/main_injector.dart';

typedef ApiResponse = Response;

/// A client for making HTTP requests to a REST API.
///
/// This client handles authentication, request formation, and response parsing.
class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  /// Creates an [ApiClient] instance.
  ///
  /// [baseUrl] is required and specifies the base URL for all API requests.
  /// [dio] and [secureStorage] are optional and allow for dependency injection.
  ApiClient({
    required Dio dio,
    required FlutterSecureStorage secureStorage,
  })  : _dio = dio,
        _secureStorage = secureStorage {
    // Handle network errors
    _dio.interceptors.add(BearerTokenInterceptor(sl()));
    //_dio.interceptors.add(LoggerInterceptor());
  }

  /// Sets the authentication token for subsequent requests.
  ///
  /// Retrieves the token from secure storage and adds it to the request headers.
  Future<void> _setAuthToken() async {
    final token = await _secureStorage.read(key: 'auth_token');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  /// Makes an HTTP request to the API.
  ///
  /// This is a private method used by public methods like [get], [post], etc.
  /// It handles setting the auth token and forming the full URL.
  ///
  /// [method] is the HTTP method (GET, POST, etc.).
  /// [path] is the API endpoint path.
  /// [queryParameters] are optional query string parameters.
  /// [data] is the request body for POST, PUT, and PATCH requests.
  /// [options] allows for custom Dio options to be set.
  ///
  /// Returns a [Future] that completes with a [Response] object.
  Future<Response<T>> _request<T>({
    required HttpMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    await _setAuthToken();

    final response = await _dio.request<T>(
      path,
      options: options?.copyWith(method: method.name.toUpperCase()) ??
          Options(method: method.name.toUpperCase()),
      queryParameters: queryParameters,
      data: data,
    );

    return response;
  }

  /// Performs a GET request to the specified [path].
  ///
  /// [queryParameters] can be used to add query string parameters.
  /// [options] allows for custom Dio options to be set.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _request<T>(
        method: HttpMethod.get,
        path: path,
        queryParameters: queryParameters,
        options: options,
      );

  /// Performs a POST request to the specified [path].
  ///
  /// [data] is the request body.
  /// [queryParameters] can be used to add query string parameters.
  /// [options] allows for custom Dio options to be set.
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _request<T>(
        method: HttpMethod.post,
        path: path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  /// Performs a PUT request to the specified [path].
  ///
  /// [data] is the request body.
  /// [queryParameters] can be used to add query string parameters.
  /// [options] allows for custom Dio options to be set.
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _request<T>(
        method: HttpMethod.put,
        path: path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  /// Performs a PATCH request to the specified [path].
  ///
  /// [data] is the request body.
  /// [queryParameters] can be used to add query string parameters.
  /// [options] allows for custom Dio options to be set.
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _request<T>(
        method: HttpMethod.patch,
        path: path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  /// Performs a DELETE request to the specified [path].
  ///
  /// [data] is the request body, if needed.
  /// [queryParameters] can be used to add query string parameters.
  /// [options] allows for custom Dio options to be set.
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _request<T>(
        method: HttpMethod.delete,
        path: path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  /// Sets the authentication token in secure storage.
  ///
  /// This token will be used for subsequent API requests.
  Future<void> setAuthToken(String token) =>
      _secureStorage.write(key: 'auth_token', value: token);

  /// Clears the authentication token from secure storage.
  ///
  /// This can be used for logging out or invalidating the current session.
  Future<void> clearAuthToken() => _secureStorage.delete(key: 'auth_token');
}

/// Enumeration of HTTP methods supported by the API client.
enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
}
