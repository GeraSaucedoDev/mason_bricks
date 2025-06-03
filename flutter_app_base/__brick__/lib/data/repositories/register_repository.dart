import 'package:mason_test_a/core/services/api/api_client.dart';
import '../../core/services/logger/app_logger.dart';

class RegisterRepository {
  RegisterRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<String> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      /*
      final data = {
        "email": email,
        "password": password,
        "username": username,
        // otros campos
      };

      final result = await _apiClient.post(
        'register_user_link',
        data: data,
      );

      if (result.statusCode != 200) throw Exception('Error on registration');

      await _saveTokens(result.data);
      return result.data['access_token'];
      */
      return '';
    } catch (e) {
      AppLogger.e('RegisterRepository | registerUser() \n\n$e');
      rethrow;
    }
  }

  Future<void> sendConfirmationCode({
    required String email,
  }) async {
    try {
      /* final queryParams = {"email": email};

      await _apiClient.post(
        'send_confirmation_code_link',
        queryParameters: queryParams,
      ); */
    } catch (e) {
      AppLogger.e('RegisterRepository | sendConfirmationCode() \n\n$e');
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
      AppLogger.e('RegisterRepository | verifyAccount() \n\n$e');
      rethrow;
    }
  }

  Future<void> sendForgotPasswordCode({
    required String email,
  }) async {
    try {
      /*
      final queryParams = {
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

  Future<bool> validateOtpCode({
    required String email,
    required String otpCode,
  }) async {
    try {
/*       final data = {
        'email': email,
        'otp_code': otpCode,
      };

      final response = await _apiClient.post(
        'validate_otp_code_link', // Cambia esta URL por la real
        data: data,
      );

      final isValid = response.data['valid'] as bool? ?? false;
      return isValid;
 */

      return true;
    } catch (e) {
      AppLogger.e('RegisterRepository | validateOtpCode() \n\n$e');
      rethrow;
    }
  }
}
