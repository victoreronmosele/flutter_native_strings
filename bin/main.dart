import 'dart:convert' as json;
import 'dart:io';
import 'package:xml/xml.dart';

import 'package:flutter_native_strings/flutter_native_strings.dart';

Future<void> main(List<String> args) async {
  final LoggerI _logger = Logger(ioSink: IOSink(stdout));

  _logger.printMessage(message: 'Welcome to Flutter Native Strings v0.0.1\n');

  try {
    final File arbFile = File('assets/en.arb');
    final String arbFileContentAsString = arbFile.readAsStringSync();
    final Map<String, dynamic> arbFileContentAsMap =
        json.jsonDecode(arbFileContentAsString);
    final Map<String, dynamic> stringNameToContentMap = arbFileContentAsMap;

    final File destinationFile =
        File('android/app/src/main/res/values/strings.xml');

    if (!destinationFile.existsSync()) {
      destinationFile.createSync();
    }

    _logger.printMessage(message: 'Generating android string resource...\n');

    final XmlBuilder xmlBuilder = XmlBuilder();
    xmlBuilder.processing('xml', 'version="1.0" encoding="utf-8"');
    xmlBuilder.element('resources', nest: () {
      for (var i = 0; i < stringNameToContentMap.length; i++) {
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

    _logger.printMessage(
        message: 'Done! \n\nGenerated ${destinationFile.path}');
  } catch (e) {
    _logger.printMessage(message: 'Error occured: $e');
  }
}
