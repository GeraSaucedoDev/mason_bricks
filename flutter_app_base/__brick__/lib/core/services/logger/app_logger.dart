import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:{{app_name}}/core/services/logger/log_reporter/log_reporter.dart';
import 'package:{{app_name}}/core/services/logger/reported_error.dart';

class AppLogger {
  static final Logger _logger = Logger(printer: SimplePrinter(colors: true));

  static LogReporter? _reporter;

  /// Global data that will be added to all logs
  static Map<String, dynamic> _globalData = {};

  /// Sets an external reporter for additional log processing
  static void setReporter(LogReporter reporter) {
    _reporter = reporter;
  }

  static void initialize() {
    // Example custom reporter
    //final reporter = CustomReporter();
    //AppLogger.setReporter(reporter);

    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.e(
        details.exceptionAsString(),
        details.exception,
        details.stack,
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.e('Async Error', error, stack);
      return true;
    };
  }

  /// Sets global data that will be included in all subsequent logs
  static void setGlobalData(Map<String, dynamic> data) {
    _globalData = data;
  }

  /// Adds data to the global data map
  static void addGlobalData(Map<String, dynamic> data) {
    _globalData.addAll(data);
  }

  /// Clears all global data
  static void clearGlobalData() {
    _globalData.clear();
  }

  /// Combines global data with log-specific data
  static Map<String, dynamic> _combineData(Map<String, dynamic>? logData) {
    return {..._globalData, if (logData != null) ...logData};
  }

  /// Logs an info message with optional additional data
  static void i(String message, [Map<String, dynamic>? data]) {
    if (kDebugMode) {
      final combinedData = _combineData(data);
      _logger.i(
        combinedData.isEmpty
            ? message
            : '$message\nData: ${jsonEncode(combinedData)}',
      );
    }
  }

  /// Logs a warning message with optional additional data
  static void w(String message, [Map<String, dynamic>? data]) {
    if (kDebugMode) {
      final combinedData = _combineData(data);
      _logger.w(
        combinedData.isEmpty
            ? message
            : '$message\nData: ${jsonEncode(combinedData)}',
      );
    }
  }

  /// Logs an error and wraps it to prevent duplicate reporting
  static dynamic e(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  ]) {
    final combinedData = _combineData(data);

    if (kDebugMode) {
      _logger.e(
        combinedData.isEmpty
            ? message
            : '$message\nData: ${jsonEncode(combinedData)}',
        error: error,
        stackTrace: stackTrace,
      );
    }

    if (error is ReportedError) {
      return error;
    }

    if (error != null) {
      _reporter?.logError(error, stackTrace, combinedData);
      return ReportedError(error, stackTrace, combinedData);
    } else {
      _reporter?.logError(message, null, combinedData);
      return ReportedError(message, null, combinedData);
    }
  }
}
