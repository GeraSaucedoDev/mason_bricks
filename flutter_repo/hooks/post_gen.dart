import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final pluralName = context.vars['plural_name'] as String;
  final appName = context.vars['app_name'] as String;
  final pascal = _pascalCase(pluralName); // TransferOrders
  final snake = _snakeCase(pluralName); // transfer_orders

  final repoClass = '${pascal}Repository';
  final repoImport =
      "import 'package:${appName}/data/repositories/${snake}_repository.dart';\n";
  final newLine =
      "  sl.registerLazySingleton(() => $repoClass(apiClient: sl()));\n";

  final file = File('lib/data/repositories/repositories_injector.dart');

  if (await file.exists()) {
    var content = await file.readAsString();

    // Agregar import si no existe
    if (!content.contains(repoImport)) {
      final importPattern = RegExp(r"(import\s+'package:[^']+?';\n)+");
      content = content.replaceFirstMapped(importPattern, (match) {
        return '${match.group(0)}$repoImport';
      });
    }

    // Agregar línea en el método si no existe
    final methodPattern =
        RegExp(r'void repositoriesInjector\(\) \{([\s\S]*?)\}');
    content = content.replaceFirstMapped(methodPattern, (match) {
      final body = match.group(1)!;
      if (body.contains(repoClass)) return match.group(0)!; // evitar duplicados
      return 'void repositoriesInjector() {\n$body$newLine}';
    });

    await file.writeAsString(content);
    context.logger.info('✅ Se agregó $repoClass y su import');
  } else {
    context.logger.err('❌ No se encontró el archivo: ${file.path}');
    context.logger
        .err('❌ Agrege el repositorio en el service locator manualmente');
  }
}

// Mejorado para manejar espacios, guiones, camelCase, etc.
String _snakeCase(String input) {
  final words = input
      .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}')
      .replaceAll(RegExp(r'[\s\-]+'), '_')
      .toLowerCase()
      .split('_')
      .where((w) => w.isNotEmpty);
  return words.join('_');
}

String _pascalCase(String input) {
  final words = input
      .replaceAll(RegExp(r'[\s_\-]+'), ' ')
      .split(' ')
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase());
  return words.join();
}
