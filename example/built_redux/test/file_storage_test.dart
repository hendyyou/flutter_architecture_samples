import 'dart:io';

import 'package:built_redux_sample/data/file_storage.dart';
import 'package:built_redux_sample/models/todo.dart';
import 'package:test/test.dart';

main() {
  group('FileStorage', () {
    final todos = [new Todo("Yep")];
    final directory = Directory.systemTemp.createTemp('__storage_test__');
    final storage = new FileStorage(
      '_test_tag_',
      () => directory,
    );

    tearDownAll(() async {
      final tempDirectory = await directory;

      tempDirectory.deleteSync(recursive: true);
    });

    test('Should persist TodoEntities to disk', () async {
      final file = await storage.saveTodos(todos);

      expect(file.existsSync(), isTrue);
    });

    test('Should load TodoEntities from disk', () async {
      final loadedTodos = await storage.loadTodos();

      expect(loadedTodos, todos);
    });
  });
}
