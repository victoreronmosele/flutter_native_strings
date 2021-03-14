library flutter_native_strings;

import 'dart:convert' as json;

import 'package:file/file.dart';
import 'package:flutter_native_strings/src/data/constants.dart';
import 'package:flutter_native_strings/src/util/logger/logger.dart';
import 'package:flutter_native_strings/src/util/string_resource_creator/string_resource_creator_i.dart';
import 'package:meta/meta.dart';

class FlutterNativeStrings {
  void generateNativeStrings(
      {@required LoggerI logger,
      @required FileSystem fileSystem,
      @required String arbFilePath,
      @required StringResourceCreatorI androidStringResourceCreator}) {
    try {
      logger.printMessage(
          message:
              'Welcome to Flutter Native Strings ${Constants.versionNumber}\n');

      final File arbFile = fileSystem.file(arbFilePath);
      final String arbFileContentAsString = arbFile.readAsStringSync();
      final Map<String, dynamic> arbFileContentAsMap =
          json.jsonDecode(arbFileContentAsString);
      final Map<String, dynamic> stringNameToContentMap = arbFileContentAsMap;

      androidStringResourceCreator.createStringResource(
          stringNameToContentMap: stringNameToContentMap,
          fileSystem: fileSystem,
          logger: logger);
    } catch (e) {
      logger.printMessage(message: 'Error occured: $e');
    }
  }
}
