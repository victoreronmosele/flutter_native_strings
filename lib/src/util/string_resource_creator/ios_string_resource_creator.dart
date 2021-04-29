import 'dart:io';

import 'package:flutter_native_strings/src/util/logger/logger.dart';
import 'package:file/src/interface/file_system.dart';
import 'package:flutter_native_strings/src/util/string_resource_creator/string_resource_creator_i.dart';

class IOSStringResourceCreator implements StringResourceCreatorI {
  @override
  void createStringResource(
      {Map<String, dynamic> stringNameToContentMap,
      FileSystem fileSystem,
      LoggerI logger}) {
    try {
      logger.printMessage(message: 'Generating ios string resource...\n');
      final String ioSStringResourceDestinationPath =
          'ios/Runner/en.lproj/Localizable.strings';

      final File destinationFile =
          fileSystem.file(ioSStringResourceDestinationPath);

      if (!destinationFile.existsSync()) {
        destinationFile.createSync(recursive: true);
      }

      final int numberOfStringsToGenerate = stringNameToContentMap.length;

      destinationFile.writeAsStringSync(stringNameToContentMap.toString());

      logger.printMessage(
          message:
              'Done! \n\nGenerated ${numberOfStringsToGenerate} string${numberOfStringsToGenerate == 1 ? '' : 's'} to ${destinationFile.path}');
    } catch (e) {
      print(e);
    }
  }
}
