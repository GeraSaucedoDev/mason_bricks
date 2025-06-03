import 'package:{{app_name}}/core/services/api/api_client.dart';
import 'package:{{app_name}}/core/services/logger/app_logger.dart';
import 'package:{{app_name}}/domain/models/{{singular_name.snakeCase()}}.dart';
import 'package:{{app_name}}/environments/env_config.dart';

class {{plural_name.pascalCase()}}Repository {
  {{plural_name.pascalCase()}}Repository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;
  final String _apiUrl = EnvConfig.apiUrl;

  Future<List<{{singular_name.pascalCase()}}>> get{{plural_name.pascalCase()}}({
    int page = 0,
    int limit = 30,
    String query = '',
  }) async {
    try {
      // TODO UPDATE QUERY PARAMS TO GET DATAA
      final params = {
        '_limit': limit,
        '_page': page,
        if (query.isNotEmpty) 'query': query,
      };

      final result = await _apiClient.get(
        '$_apiUrl/{{plural_name.snakeCase()}}',
        queryParameters: params,
      );

      final data = result.data as List;

      final List<{{singular_name.pascalCase()}}> {{plural_name.camelCase()}} = data.map(({{singular_name.camelCase()}}) => {{singular_name.pascalCase()}}.fromMap({{singular_name.camelCase()}})).toList();

      return {{plural_name.camelCase()}};
    } catch (e, stack) {
      throw AppLogger.e('$runtimeType | get{{plural_name.pascalCase()}}()', e, stack);
    }
  }

  Future<{{singular_name.pascalCase()}}> get{{singular_name.pascalCase()}}(String id) async {
    try {
      final result = await _apiClient.get('$_apiUrl/{{plural_name.snakeCase()}}/$id');

      final data = result.data;
      final {{singular_name.camelCase()}} = {{singular_name.pascalCase()}}.fromMap(data);

      return {{singular_name.camelCase()}};
    } catch (e, stack) {
      throw AppLogger.e('$runtimeType | get{{singular_name.pascalCase()}}ById()', e, stack);
    }
  }

  Future<{{singular_name.pascalCase()}}> create{{singular_name.pascalCase()}}({{singular_name.pascalCase()}} {{singular_name.snakeCase()}}) async {
    try {
      // TODO UPDATE CREATION METHOD
      final body = {'title': '', 'body': '', 'userId': 1,};

      final result = await _apiClient.post('$_apiUrl/{{plural_name.snakeCase()}}', data: body);

      final data = result.data;
      final created{{singular_name.pascalCase()}} = {{singular_name.pascalCase()}}.fromMap(data);

      return created{{singular_name.pascalCase()}};
    } catch (e, stack) {
      throw AppLogger.e('$runtimeType | create{{singular_name.pascalCase()}}()', e, stack);
    }
  }

  Future<{{singular_name.pascalCase()}}> update{{singular_name.pascalCase()}}({
    required String id,
    String title = '',
    int? userId,
  }) async {
    try {
      // TODO UPDATE UPDATE BODY METHOD
      final body = {
        if (title.isNotEmpty) 'title': title,
        if (userId != null) 'userId': userId,
      };

      final result = await _apiClient.patch('$_apiUrl/{{plural_name.snakeCase()}}/$id', data: body);

      final data = result.data;
      final updated{{singular_name.pascalCase()}} = {{singular_name.pascalCase()}}.fromMap(data);

      return updated{{singular_name.pascalCase()}};
    } catch (e, stack) {
      throw AppLogger.e('$runtimeType | update{{singular_name.pascalCase()}}()', e, stack);
    }
  }

  Future<void> delete{{singular_name.pascalCase()}}(String id) async {
    try {
      await _apiClient.delete('$_apiUrl/{{plural_name.snakeCase()}}/$id');
    } catch (e, stack) {
      throw AppLogger.e('$runtimeType | delete{{singular_name.pascalCase()}}()', e, stack);
    }
  }
}
