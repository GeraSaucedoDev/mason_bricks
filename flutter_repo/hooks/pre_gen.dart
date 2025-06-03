import 'dart:io';
import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future<void> run(HookContext context) async {
  final logger = context.logger;

  // Buscar el archivo pubspec.yaml
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    logger.err('No se encontró pubspec.yaml');
    return;
  }

  // Leer y parsear el pubspec
  final content = pubspecFile.readAsStringSync();
  final pubspec = loadYaml(content);

  // Obtener el nombre del paquete
  final packageName = pubspec['name'] as String;

  // Agregar como variable app_name
  context.vars['app_name'] = packageName;

  logger.success('Nombre de la app: $packageName');
}
