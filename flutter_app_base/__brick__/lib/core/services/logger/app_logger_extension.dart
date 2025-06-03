import 'package:{{app_name}}/core/services/logger/app_logger.dart';

extension AppLoggerExtension on Object {
  void appLogI(String message, [Map<String, dynamic>? data]) {
    AppLogger.i('[$runtimeType] $message', data);
  }

  void appLogW(String message, [Map<String, dynamic>? data]) {
    AppLogger.w('[$runtimeType] $message', data);
  }

  dynamic appLogE(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  ]) {
    return AppLogger.e('[$runtimeType] $message', error, stackTrace, data);
  }
}
