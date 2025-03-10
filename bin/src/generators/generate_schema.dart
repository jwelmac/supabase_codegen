import 'dart:io';

import '../src.dart';

Future<void> generateSchemaFiles(
  Map<String, List<Map<String, dynamic>>> tables,
) async {
  final enumsDir = Directory('$root/enums');
  await enumsDir.create(recursive: true);

  // Generate enums file
  await generateEnums(enumsDir);

  logger.d('[GenerateTypes] Successfully generated schema files');
}
