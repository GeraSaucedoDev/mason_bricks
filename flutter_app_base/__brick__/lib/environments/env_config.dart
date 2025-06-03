import 'package:{{app_name}}/environments/env_config_dev.dart';
import 'package:{{app_name}}/environments/env_config_prod.dart';
import 'package:{{app_name}}/environments/env_config_stg.dart';
import 'package:{{app_name}}/environments/env_vars.dart';

class EnvConfig {
  // Using dart define
  //static const _flavor = String.fromEnvironment('ENV', defaultValue: 'dev');

  static const _flavor = String.fromEnvironment('FLUTTER_APP_FLAVOR') != ''
      ? String.fromEnvironment('FLUTTER_APP_FLAVOR')
      : String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  // If you need to add more environments, just create a new Config class
  // and add the corresponding case in the _getConfig() method
  static final EnvVars _instance = _getConfig();

  static EnvVars _getConfig() {
    switch (_flavor.toLowerCase()) {
      case 'prod':
        return ProdConfig();
      case 'stg':
        return StgConfig();
      case 'dev':
        return DevConfig();
      default:
        return DevConfig();
    }
  }

  static bool get isProd => _flavor == 'prod';
  static bool get isDev => _flavor == 'dev';
  static bool get isStg => _flavor == 'stg';

  // Declare variables used on env_vars.dart
  static String get envName => _instance.envName;
  static String get apiUrl => _instance.apiUrl;
}
