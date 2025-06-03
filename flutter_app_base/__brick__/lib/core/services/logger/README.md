# Core Logger

Flutter logging system that handles local logs and reporting to external services like Crashlytics or Sentry, with support for additional data and error deduplication.

## Project Structure

```
lib/
  core/
    logger/
      ├── log_reporter/
      │   ├── log_reporter.dart           # Base interface for reporters
      │   ├── crashlytics_log_reporter.dart    # Example Crashlytics implementation
      │   └── sentry_log_reporter.dart         # Example Sentry implementation
      ├── reported_error.dart     # Wrapper class for reported errors
      └── app_logger.dart         # Main logger implementation
```

## Main Components

### 1. AppLogger (app_logger.dart)

Main logging class with static methods:

```dart
// Info log (debug only)
AppLogger.i("Message");

// Warning log (debug only)
AppLogger.w("Warning");

// Error log (debug and release)
AppLogger.e("Error", error, stackTrace);
```

### 2. LogReporter (log_reporter/log_reporter.dart)

Interface that defines how logs are reported to external services:

```dart
abstract class LogReporter {
  void logError(dynamic error, [StackTrace? stackTrace, Map<String, dynamic>? data]);
  void logInfo(String message, [Map<String, dynamic>? data]);
  void logWarning(String message, [Map<String, dynamic>? data]);
}
```

## Use Cases

### 1. Basic Logging

```dart
// Anywhere in your code
void loginUser() {
  try {
    AppLogger.i("Starting login process");  // Only visible in debug

    if (lowMemoryCondition) {
      AppLogger.w("Low memory while attempting login");  // Only visible in debug
    }

    // Some process that might fail
    throw Exception("Invalid credentials");
  } catch (e, stack) {
    // This error will be visible in debug and sent to reporter in release
    throw AppLogger.e("Login error", e, stack);
  }
}
```

### 2. Logging with Additional Data

```dart
// Log with specific data
AppLogger.i("User logged in", {
  'userId': '123',
  'email': 'user@example.com',
  'loginMethod': 'google'
});

// Global data for the entire session
AppLogger.setGlobalData({
  'deviceId': 'ABC123',
  'appVersion': '1.0.0',
  'buildNumber': '42'
});

// Add additional data to globals
AppLogger.addGlobalData({
  'networkType': 'wifi',
  'lastScreenView': 'HomeScreen'
});
```

### 3. Error Handling in Layers

```dart
// 1. API Layer
class ApiService {
  Future<void> fetchData() async {
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw HttpException('HTTP ${response.statusCode}');
      }
    } catch (e, stack) {
      // This error WILL be reported
      throw AppLogger.e(
        "API fetchData error",
        e,
        stack,
        {'url': url, 'statusCode': response.statusCode}
      );
    }
  }
}

// 2. Repository Layer
class UserRepository {
  Future<void> getUserData() async {
    try {
      await _apiService.fetchData();
    } catch (e, stack) {
      // This error WON'T be reported (already reported in API)
      throw AppLogger.e(
        "Repository getUserData error",
        e,
        stack,
        {'method': 'getUserData'}
      );
    }
  }
}

// 3. Bloc/Cubit Layer
class UserBloc {
  Future<void> loadUser() async {
    try {
      await _repository.getUserData();
    } catch (e, stack) {
      // This error WON'T be reported (already reported in API)
      AppLogger.e(
        "Bloc loadUser error",
        e,
        stack,
        {'state': 'loading'}
      );
      // Handle error...
    }
  }
}
```

### 4. Custom Reporter Implementation

```dart
import 'package:your_app/core/logger/log_reporter/log_reporter.dart';

class CustomReporter implements LogReporter {
  @override
  void logError(dynamic error, [StackTrace? stackTrace, Map<String, dynamic>? data]) {
    // Example: Send to custom monitoring service
    monitoringService.sendError(
      error: error,
      stackTrace: stackTrace,
      metadata: data,
      timestamp: DateTime.now(),
    );
  }

  @override
  void logInfo(String message, [Map<String, dynamic>? data]) {
    monitoringService.sendLog(
      level: 'INFO',
      message: message,
      metadata: data,
    );
  }

  @override
  void logWarning(String message, [Map<String, dynamic>? data]) {
    monitoringService.sendLog(
      level: 'WARNING',
      message: message,
      metadata: data,
    );
  }
}

// Usage
void initializeLogger() {
  final reporter = CustomReporter();
  AppLogger.setReporter(reporter);
}
```

## Global Error Handling Initialization

Here’s how to set up global error handlers to capture both Flutter framework errors and asynchronous errors throughout the application. Ensure this is called at the beginning of your application, typically in the `main` function.

```dart
/// Initializes global error handlers for the application.
static void initialize() {
  // Capture and log errors from the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger.e(details.exceptionAsString(), details.exception, details.stack);
  };

  // Capture and log asynchronous errors across the platform.
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e('Async Error', error, stack);
    return true; // Indicates that the error has been handled.
  };
}
```

You need to call the initialize method in the main function to ensure error handling is set up before running the app

```dart
void main() {
  // Initialize global error handling.
  AppLogger.initialize();

  // Run the Flutter application.
  runApp(MyApp());
}
```

## Behavior by Mode

### Debug Mode

- All logs (`i`, `w`, `e`) are shown in the console
- Errors are sent to the reporter if configured
- Includes full stack traces and additional data
- Logs include emojis and colors for better readability

### Release Mode

- Console logs are disabled
- Only errors (`e`) are sent to the reporter
- No performance impact from debug logs
- Additional data is only sent to the reporter

## Important Notes

1. The Crashlytics and Sentry implementations in the `log_reporter` folder are examples. You must implement the specific logic for your configuration.

2. To avoid error duplication, the system uses `ReportedError`:

   - An error is only reported the first time it passes through `AppLogger.e`
   - Subsequent reports of the same error are ignored
   - This prevents spam in your monitoring services

3. Global data persists until:

   - `clearGlobalData()` is called
   - The app is restarted
   - It's overwritten with `setGlobalData()`

4. In release mode, the logger is optimized to have zero performance impact when using `i()` and `w()`
