import 'dart:io';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter_native_strings/src/util/android_string_resource_creator.dart';
import 'package:flutter_native_strings/src/util/logger.dart';
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

    FileSystem fileSystem;

    setUp(() async {
      fileSystem = MemoryFileSystem();
      final Directory directory = fileSystem.directory(androidFileDirectory);
      await directory.create(recursive: true);
    });

    test('creates a file at $androidFilePath if it does not exist', () {
      final AndroidStringResourceCreator androidStringResourceCreator =
          AndroidStringResourceCreator();

      expect(fileSystem.file(androidFilePath).existsSync(), false);

      androidStringResourceCreator.createStringResource(
          logger: MockLogger(),
          fileSystem: fileSystem,
          stringNameToContentMap: sampleStringNameToContentMap);

      expect(fileSystem.file(androidFilePath).existsSync(), true);
    });

    test('does not create a new file at $androidFilePath if it exists already',
        () {
      final AndroidStringResourceCreator androidStringResourceCreator =
          AndroidStringResourceCreator();

      final File file = fileSystem.file(androidFilePath)..createSync();

      expect(fileSystem.file(androidFilePath).existsSync(), true);

      androidStringResourceCreator.createStringResource(
          logger: MockLogger(),
          fileSystem: fileSystem,
          stringNameToContentMap: sampleStringNameToContentMap);

      expect(
          (fileSystem.identicalSync(
              fileSystem.file(androidFilePath).path, file.path)),
          true);
    });

    test(
      'generates the correct xml content for stringNameToContentMap with a single item',
      () {
        final AndroidStringResourceCreator androidStringResourceCreator =
            AndroidStringResourceCreator();

        androidStringResourceCreator.createStringResource(
            logger: MockLogger(),
            fileSystem: fileSystem,
            stringNameToContentMap: {'hello': 'Hello'});

        final File fileWithGeneratedContent = fileSystem.file(androidFilePath);

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
          fileSystem: fileSystem,
          stringNameToContentMap: {'hello': 'Hello', 'world': 'World'});

      final File fileWithGeneratedContent = fileSystem.file(androidFilePath);

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
          fileSystem: fileSystem,
          stringNameToContentMap: {});

      final File fileWithGeneratedContent = fileSystem.file(androidFilePath);

      final String generatedContentString =
          fileWithGeneratedContent.readAsStringSync();

      final String expectedXmlContent =
          '''<?xml version="1.0" encoding="utf-8"?>
<resources/>''';

      expect(generatedContentString, expectedXmlContent);
    });
  });
}
