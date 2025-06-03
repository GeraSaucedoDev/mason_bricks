import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final pluralName = context.vars['plural_name'] as String;
  final appName = context.vars['app_name'] as String;

  final pascal = _pascalCase(pluralName);
  final snake = _snakeCase(pluralName);
  final camel = _camelCase(pluralName);

  // Clases y imports
  final blocClass = '${pascal}Bloc';
  //final repoClass = '${pascal}Repository';

  final blocImport =
      "import 'package:$appName/presentation/blocs/$snake/${snake}_bloc.dart';\n";

  // Líneas a agregar
  final blocProviderLine =
      "\n        BlocProvider(create: (context) => sl<$blocClass>()),\n";
  final blocInjectorLine =
      "  sl.registerFactory(() => $blocClass(${camel}Repository: sl()));\n";

  // Procesar ambos archivos
  await _processAppBlocProvider(
      context, blocImport, blocProviderLine, blocClass);
  await _processBlocInjector(context, blocImport, blocInjectorLine, blocClass);
}

Future<void> _processAppBlocProvider(HookContext context, String blocImport,
    String blocProviderLine, String blocClass) async {
  final file = File('lib/presentation/blocs/app_bloc_provider.dart');

  if (!await file.exists()) {
    context.logger.err('❌ No se encontró: ${file.path}');
    return;
  }

  var content = await file.readAsString();

  // Agregar import si no existe
  if (!content.contains(blocImport.trim())) {
    final importPattern = RegExp(r"(import\s+'package:[^']+?';\n)+");
    content = content.replaceFirstMapped(importPattern, (match) {
      return '${match.group(0)}$blocImport';
    });
  }

  // Agregar BlocProvider si no existe
  if (!content.contains(blocClass)) {
    final providersPattern = RegExp(r'providers:\s*\[([\s\S]*?)\s*\],');
    content = content.replaceFirstMapped(providersPattern, (match) {
      final providersContent = match.group(1)!;

      // Buscar el último BlocProvider activo (no comentado)
      final lastProviderMatch = RegExp(r'(\s*BlocProvider\([^)]+\)\),)\s*')
          .allMatches(providersContent)
          .where((m) => !m.group(0)!.trim().startsWith('/*'))
          .lastOrNull;

      if (lastProviderMatch != null) {
        final insertPosition = lastProviderMatch.end;
        final beforeInsert = providersContent.substring(0, insertPosition);
        final afterInsert = providersContent.substring(insertPosition);
        return 'providers: [\n$beforeInsert$blocProviderLine$afterInsert      ],';
      } else {
        // Si no hay providers activos, agregar después de los comentados
        return 'providers: [\n$providersContent$blocProviderLine      ],';
      }
    });
  }

  await file.writeAsString(content);
  context.logger.info('✅ Se agregó $blocClass a AppBlocProvider');
}

Future<void> _processBlocInjector(HookContext context, String blocImport,
    String blocInjectorLine, String blocClass) async {
  final file = File('lib/presentation/blocs/bloc_injector.dart');

  if (!await file.exists()) {
    context.logger.err('❌ No se encontró: ${file.path}');
    return;
  }

  var content = await file.readAsString();

  // Agregar import del BLoC si no existe
  if (!content.contains(blocImport.trim())) {
    final importPattern = RegExp(r"(import\s+'package:[^']+?';\n)+");
    content = content.replaceFirstMapped(importPattern, (match) {
      return '${match.group(0)}$blocImport';
    });
  }

  // Agregar línea en el método si no existe
  if (!content.contains(blocClass)) {
    final methodPattern = RegExp(r'void blocInjector\(\) \{([\s\S]*?)\}');
    content = content.replaceFirstMapped(methodPattern, (match) {
      final body = match.group(1)!;

      // Buscar la última línea activa (no comentada)
      final lines = body.split('\n');
      int insertIndex = -1;

      for (int i = lines.length - 1; i >= 0; i--) {
        final line = lines[i].trim();
        if (line.startsWith('sl.registerFactory') && !line.startsWith('//')) {
          insertIndex = i + 1;
          break;
        }
      }

      if (insertIndex != -1) {
        lines.insert(insertIndex, blocInjectorLine.trimRight());
        return 'void blocInjector() {\n${lines.join('\n')}\n}';
      } else {
        // Si no hay líneas activas, agregar al final
        return 'void blocInjector() {\n$body$blocInjectorLine}';
      }
    });
  }

  await file.writeAsString(content);
  context.logger.info('✅ Se agregó $blocClass a blocInjector');
}

// Utilidades para conversión de casos
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

String _camelCase(String input) {
  final words = input
      .replaceAll(RegExp(r'[\s_\-]+'), ' ')
      .split(' ')
      .where((w) => w.isNotEmpty)
      .toList();

  if (words.isEmpty) return '';

  final firstWord = words.first.toLowerCase();
  final remainingWords = words
      .skip(1)
      .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase());

  return [firstWord, ...remainingWords].join();
}
