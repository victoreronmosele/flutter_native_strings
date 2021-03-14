library flutter_native_strings;

import 'dart:convert' as json;
import 'dart:io' show stdout;
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_native_strings/src/data/constants.dart';
import 'package:flutter_native_strings/src/util/logger/logger.dart';
import 'package:flutter_native_strings/src/util/string_resource_creator/android_string_resource_creator.dart';
import 'package:flutter_native_strings/src/util/string_resource_creator/string_resource_creator_i.dart';


class FlutterNativeStrings {
  void generateNativeStrings() {
    final LoggerI _logger = Logger(ioSink: IOSink(stdout));

    _logger.printMessage(
        message:
            'Welcome to Flutter Native Strings ${Constants.versionNumber}\n');

    try {
      final String arbFilePath = 'assets/en.arb';
      final FileSystem fileSystem = LocalFileSystem();

      final File arbFile = fileSystem.file(arbFilePath);
      final String arbFileContentAsString = arbFile.readAsStringSync();
      final Map<String, dynamic> arbFileContentAsMap =
          json.jsonDecode(arbFileContentAsString);

      final Map<String, dynamic> stringNameToContentMap = arbFileContentAsMap;

      final StringResourceCreatorI _androidStringCreator =
          AndroidStringResourceCreator();

      _androidStringCreator.createStringResource(
          stringNameToContentMap: stringNameToContentMap,
          fileSystem: fileSystem,
          logger: _logger);
    } catch (e) {
      _logger.printMessage(message: 'Error occured: $e');
    }
  }
}
