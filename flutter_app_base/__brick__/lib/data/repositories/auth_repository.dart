import 'package:{{app_name}}/core/services/api/api_client.dart';
import 'package:{{app_name}}/core/services/storage/token_manager.dart';
import 'package:{{app_name}}/core/services/user/user_service.dart';
import 'package:{{app_name}}/domain/models/user.dart';
import '../../core/services/logger/app_logger.dart';

class AuthRepository {
  AuthRepository({
    required ApiClient apiClient,
    required TokenManager tokenManager,
    required UserService userService,
  })  : _apiClient = apiClient,
        _userService = userService,
        _tokenManager = tokenManager;

  final TokenManager _tokenManager;
  final ApiClient _apiClient;
  final UserService _userService;

  /// Checks if the user has a valid active session
  ///
  /// Uses _verifyTokenValidation() to verify if tokens are valid.
  /// Returns true if tokens are valid or can be successfully refreshed.
  /// Logs error and returns false if validation fails.

  Future<User?> isUserLogged() async {
    try {
      final accessToken = await _verifyTokenValidation();

      if (accessToken == null) return null;

      final user = _userService.getUserData(accessToken);

      return user;
    } catch (e) {
      AppLogger.e('AuthRepository | isUserLogged() \n\n$e');
      rethrow;
    }
  }

  /// Validates and refreshes authentication tokens
  ///
  /// Gets accessToken and refreshToken from storage.
  /// If accessToken has expired, attempts to get a new one using
  /// the refreshToken. If refresh succeeds, saves new token
  /// and returns true.
  ///
  /// Returns false if:
  /// - Tokens are null
  /// - Token refresh fails
  /// - Any error occurs in the process

  Future<String?> _verifyTokenValidation() async {
    try {
      final accessToken = await _tokenManager.getAccessToken();
      final refreshToken = await _tokenManager.getRefreshToken();

      if (accessToken == null || refreshToken == null) return null;

      /*  final isAccessTokenValid = isTokenValid(accessToken);
      if (!isAccessTokenValid) { */
      /*  final resultRefresh = await _apiClient.post(
        'verify_token_link',
      );

      final newAccessToken =
          resultRefresh.data['AuthenticationResult']['AccessToken']; */

      final newAccessToken = 'fake_access_token_123456';

      await _tokenManager.saveAccessToken(newAccessToken);
      return newAccessToken;
    } catch (e) {
      AppLogger.e('AuthRepository | _verifyTokenValidation() \n\n$e');
      return null;
    }
  }

  /// Performs an HTTP POST request to the server to authenticate
  /// a user. It takes as arguments the user's [email] and [password]
  ///
  /// if request was success it Return [access_token] as String,
  /// [refresh_token] and [id_token]
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final result = {
        'access_token': 'fake_access_token_123456',
        'refresh_token': 'fake_refresh_token_78910',
      };

      await _saveTokens(result);
      return result['access_token']!;

      /*
    final data = {
      "email": email,
      "password": password,
    };

    final result = await _apiClient.post(
      'login_with_email_and_pass_link',
      data: data,
    );

    if (result.statusCode != 200) throw Exception('Error on login');

    await _saveTokens(result.data);
    return result.data['access_token'];

    */
    } catch (e) {
      AppLogger.e('AuthRepository | loginWithEmailAndPassword() \n\n$e');
      rethrow;
    }
  }

  Future _saveTokens(Map<String, dynamic> data) async {
    await _tokenManager.saveAccessToken(data['access_token']);
    await _tokenManager.saveRefreshToken(data['refresh_token']);
  }

  Future<void> sendConfirmationCode({
    required String email,
  }) async {
    try {
      final queryParams = {"email": email};

      await _apiClient.post(
        'resend_code_link',
        queryParameters: queryParams,
      );
    } catch (e) {
      AppLogger.e('AuthRepository | sendConfirmationCode() \n\n$e');
      rethrow;
    }
  }

  Future<void> verifyAccount({
    required String email,
    required String confirmationCode,
  }) async {
    try {
      final data = {
        "email": email,
        "confirmation_code": confirmationCode,
      };

      await _apiClient.post(
        'verify_account_link',
        data: data,
      );
    } catch (e) {
      AppLogger.e('AuthRepository | verifyAccount() \n\n$e');
      rethrow;
    }
  }

  Future<void> sendForgotPasswordCode({
    required String email,
  }) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
/*       final queryParams = {
        "email": email,
      };

      await _apiClient.post(
        'send_forgot_password_link',
        queryParameters: queryParams,
      );
 */
    } catch (e) {
      AppLogger.e('RegisterRepository | sendForgotPasswordCode() \n\n$e');
      rethrow;
    }
  }

  Future<void> updatePassword({
    required String email,
    required String confirmationCode,
    required String newPassword,
  }) async {
    try {
/*       final data = {
        "confirmation_code": confirmationCode,
        "email": email,
        "new_password": newPassword,
      };

      await _apiClient.post(
        'update_password_link',
        data: data,
      );
 */
    } catch (e) {
      AppLogger.e('AuthRepository | updatePassword() \n\n$e');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      /*  final accessToken = await _tokenManager.getAccessToken();
      final refreshToken = await _tokenManager.getRefreshToken();

      final queryParams = {'token': accessToken, 'refresh_token': refreshToken};

      await _apiClient.post(
        'logout_link',
        queryParameters: queryParams,
      ); */
      await _tokenManager.clearTokens();
      await _userService.clearUserData();
    } catch (e) {
      AppLogger.e('AuthRepository | logout() \n\n$e');
      rethrow;
    }
  }

/*   Future<String?> cognitoSignInWithAuthCode(String authCode) async {
    try {
      final result = await _cognitoService.signInCognitoWithAuthCode(authCode);

      final idToken = result['id_token'] ?? '';
      final accessToken = result['access_token'] ?? '';
      final refreshToken = result['refresh_token'] ?? '';

      // SAVE TOKEN DATA
      await Future.wait([
        _tokenManager.saveAccessToken(accessToken),
        _tokenManager.saveRefreshToken(refreshToken),
      ]);

      AppLogger.i(idToken.toString());

      return accessToken;
    } catch (e) {
      AppLogger.e('AuthRepository | cognitoSignInWithAuthCode() \n\n$e');
      rethrow;
    }
  } */
}
