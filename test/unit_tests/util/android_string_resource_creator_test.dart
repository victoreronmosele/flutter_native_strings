import 'dart:io';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter_native_strings/src/util/logger/logger.dart';
import 'package:flutter_native_strings/src/util/string_resource_creator/android_string_resource_creator.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements LoggerI {}

void main() {
  group(AndroidStringResourceCreator, () {
    final String androidFileDirectory = 'android/app/src/main/res/values';
    final String androidFilePath = '${androidFileDirectory}/strings.xml';
    final Map<String, dynamic> sampleStringNameToContentMap = {
      'hello': 'Hello',
    };

    FileSystem memoryFileSystem;

    setUp(() async {
      memoryFileSystem = MemoryFileSystem();
      final Directory directory =
          memoryFileSystem.directory(androidFileDirectory);
      await directory.create(recursive: true);
    });

    test('creates a file at $androidFilePath if it does not exist', () {
      final AndroidStringResourceCreator androidStringResourceCreator =
          AndroidStringResourceCreator();

      expect(memoryFileSystem.file(androidFilePath).existsSync(), false);

      androidStringResourceCreator.createStringResource(
          logger: MockLogger(),
          fileSystem: memoryFileSystem,
          stringNameToContentMap: sampleStringNameToContentMap);

      expect(memoryFileSystem.file(androidFilePath).existsSync(), true);
    });

    test('does not create a new file at $androidFilePath if it exists already',
        () {
      final AndroidStringResourceCreator androidStringResourceCreator =
          AndroidStringResourceCreator();

      final File file = memoryFileSystem.file(androidFilePath)..createSync();

      expect(memoryFileSystem.file(androidFilePath).existsSync(), true);

      androidStringResourceCreator.createStringResource(
          logger: MockLogger(),
          fileSystem: memoryFileSystem,
          stringNameToContentMap: sampleStringNameToContentMap);

      expect(
          (memoryFileSystem.identicalSync(
              memoryFileSystem.file(androidFilePath).path, file.path)),
          true);
    });

    test(
      'generates the correct xml content for stringNameToContentMap with a single item',
      () {
        final AndroidStringResourceCreator androidStringResourceCreator =
            AndroidStringResourceCreator();

        androidStringResourceCreator.createStringResource(
            logger: MockLogger(),
            fileSystem: memoryFileSystem,
            stringNameToContentMap: {'hello': 'Hello'});

        final File fileWithGeneratedContent =
            memoryFileSystem.file(androidFilePath);

        final String generatedContentString =
            fileWithGeneratedContent.readAsStringSync();

        final String expectedXmlContent =
            '''<?xml version="1.0" encoding="utf-8"?>
<resources>
  <string name="hello">Hello</string>
</resources>''';

        expect(generatedContentString, expectedXmlContent);
      },
    );

    test(
        'generates the correct xml content for stringNameToContentMap with more than one',
        () {
      final AndroidStringResourceCreator androidStringResourceCreator =
          AndroidStringResourceCreator();

      androidStringResourceCreator.createStringResource(
          logger: MockLogger(),
          fileSystem: memoryFileSystem,
          stringNameToContentMap: {'hello': 'Hello', 'world': 'World'});

      final File fileWithGeneratedContent =
          memoryFileSystem.file(androidFilePath);

      final String generatedContentString =
          fileWithGeneratedContent.readAsStringSync();

      final String expectedXmlContent =
          '''<?xml version="1.0" encoding="utf-8"?>
<resources>
  <string name="hello">Hello</string>
  <string name="world">World</string>
</resources>''';

      expect(generatedContentString, expectedXmlContent);
    });

    test(
        'generates the correct xml content for stringNameToContentMap with no items',
        () {
      final AndroidStringResourceCreator androidStringResourceCreator =
          AndroidStringResourceCreator();

      androidStringResourceCreator.createStringResource(
          logger: MockLogger(),
          fileSystem: memoryFileSystem,
          stringNameToContentMap: {});

      final File fileWithGeneratedContent =
          memoryFileSystem.file(androidFilePath);

      final String generatedContentString =
          fileWithGeneratedContent.readAsStringSync();

      final String expectedXmlContent =
          '''<?xml version="1.0" encoding="utf-8"?>
<resources/>''';

      expect(generatedContentString, expectedXmlContent);
    });
  });
}
