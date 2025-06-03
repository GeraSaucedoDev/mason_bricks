import 'package:{{app_name}}/environments/env_vars.dart';

class ProdConfig implements EnvVars {
  @override
  String get envName => 'PROD';

  @override
  // TODO: implement apiUrl
  String get apiUrl => throw UnimplementedError();
}
