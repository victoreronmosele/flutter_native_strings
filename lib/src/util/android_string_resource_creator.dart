import 'dart:io';
import 'package:flutter_native_strings/src/util/logger.dart';
import 'package:meta/meta.dart';

import 'package:flutter_native_strings/src/util/string_resource_creator_i.dart';
import 'package:xml/xml.dart';

class AndroidStringResourceCreator implements StringResourceCreatorI {
  @override
  void createStringResource(
      {@required Map<String, dynamic> stringNameToContentMap,
      @required LoggerI logger}) {
    try {
      logger.printMessage(message: 'Generating android string resource...\n');

      final String androidStringResourceDestinationPath =
          'android/app/src/main/res/values/strings.xml';
      final File destinationFile = File(androidStringResourceDestinationPath);

      if (!destinationFile.existsSync()) {
        destinationFile.createSync();
      }

      final XmlBuilder xmlBuilder = XmlBuilder();
      xmlBuilder.processing('xml', 'version="1.0" encoding="utf-8"');

      final int numberOfStringsToGenerate = stringNameToContentMap.length;

      xmlBuilder.element('resources', nest: () {
        for (var i = 0; i < numberOfStringsToGenerate; i++) {
          final name = stringNameToContentMap.keys.elementAt(i);
          final value = stringNameToContentMap.values.elementAt(i);

          xmlBuilder.element('string', nest: () {
            xmlBuilder.attribute('name', name);
            xmlBuilder.text(value);
          });
        }
      });

      final XmlDocument androidStringXml = xmlBuilder.buildDocument();

      destinationFile
          .writeAsStringSync(androidStringXml.toXmlString(pretty: true));

      logger.printMessage(
          message:
              'Done! \n\nGenerated ${numberOfStringsToGenerate} string${numberOfStringsToGenerate == 1 ? '' : 's'} to ${destinationFile.path}');
    } catch (e) {}
  }
}
