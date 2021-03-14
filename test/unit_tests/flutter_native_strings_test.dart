import 'dart:convert' as json;
import 'dart:io';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter_native_strings/flutter_native_strings.dart';
import 'package:flutter_native_strings/src/util/logger/logger.dart';
import 'package:flutter_native_strings/src/util/string_resource_creator/string_resource_creator_i.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements LoggerI {}

class MockStringResourceCreator extends Mock implements StringResourceCreatorI {
}

void main() {
  group(FlutterNativeStrings, () {
    final String arbFilePath = 'assets/en.arb';

    FlutterNativeStrings flutterNativeStrings;
    StringResourceCreatorI mockStringResourceCreator;
    FileSystem memoryFileSystem;

    setUp(() {
      flutterNativeStrings = FlutterNativeStrings();
      mockStringResourceCreator = MockStringResourceCreator();
      memoryFileSystem = MemoryFileSystem();

      final File arbFile = memoryFileSystem.file(arbFilePath);
      arbFile.createSync(recursive: true);
      arbFile.writeAsStringSync(json.jsonEncode({'hello': 'Hello World!'}));
    });

    test(
        'calls androidStringResourceCreator\'s createStringResource() method when run',
        () {
      flutterNativeStrings.generateNativeStrings(
          logger: MockLogger(),
          fileSystem: memoryFileSystem,
          arbFilePath: arbFilePath,
          androidStringResourceCreator: mockStringResourceCreator);

      verify(mockStringResourceCreator.createStringResource(
          fileSystem: anyNamed('fileSystem'),
          logger: anyNamed('logger'),
          stringNameToContentMap: anyNamed('stringNameToContentMap')));
    });

    /// This tests that the catch block works to handle exceptions
    test(
        'does not propagate the exception when an exception is thrown in the try block',
        () {
      /// To simulate any exception being thrown
      when(mockStringResourceCreator.createStringResource(
              fileSystem: anyNamed('fileSystem'),
              logger: anyNamed('logger'),
              stringNameToContentMap: anyNamed('stringNameToContentMap')))
          .thenThrow(Exception(''));

      final void Function() generateNativeStringsFunction = () =>
          flutterNativeStrings.generateNativeStrings(
              logger: MockLogger(),
              fileSystem: MemoryFileSystem(),
              arbFilePath: arbFilePath,
              androidStringResourceCreator: mockStringResourceCreator);

      expect(generateNativeStringsFunction, returnsNormally);
    });
  });
}
