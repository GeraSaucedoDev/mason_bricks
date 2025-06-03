import 'package:{{app_name}}/environments/env_vars.dart';

class DevConfig implements EnvVars {
  @override
  String get envName => 'DEV';

  @override
  // TODO: implement apiUrl
  String get apiUrl => throw UnimplementedError();
}
