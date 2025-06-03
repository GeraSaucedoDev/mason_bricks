import 'package:{{app_name}}/environments/env_vars.dart';

class StgConfig implements EnvVars {
  @override
  String get envName => 'STG';

  @override
  // TODO: implement apiUrl
  String get apiUrl => throw UnimplementedError();
}
