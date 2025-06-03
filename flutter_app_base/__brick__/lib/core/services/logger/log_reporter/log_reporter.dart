abstract class LogReporter {
  void logError(dynamic error, [StackTrace? stackTrace, Map<String, dynamic>? data]);
  void logInfo(String message, [Map<String, dynamic>? data]);
  void logWarning(String message, [Map<String, dynamic>? data]);
}