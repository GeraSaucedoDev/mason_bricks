import 'package:mason_test_a/core/services/config_manager/config_manager.dart';
import 'package:mason_test_a/core/services/logger/app_logger.dart';

class ConfigRepository {
  ConfigRepository({
    //required ApiClient apiClient,
    required ConfigManager configManager,
  }) : //_apiClient = apiClient,
       _configManager = configManager,
       super();

  //final ApiClient _apiClient;
  final ConfigManager _configManager;

  Future<void> getAppConfig() async {
    try {
      // Api call simulation time
      await Future.delayed(const Duration(milliseconds: 500));

      // Get vars from dart define
      final configSource = const String.fromEnvironment('CONFIG_SOURCE');

      // Set var into config manager
      _configManager.configSource = configSource;
    } catch (e, stack) {
      throw AppLogger.e('$runtimeType | getAppConfig', e, stack);
    }
  }
}
