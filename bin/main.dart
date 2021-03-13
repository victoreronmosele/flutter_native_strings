import 'dart:convert' as json;
import 'dart:io';

import 'package:flutter_native_strings/flutter_native_strings.dart';

Future<void> main(List<String> args) async {
  final LoggerI _logger = Logger(ioSink: IOSink(stdout));

  _logger.printMessage(message: 'Welcome to Flutter Native Strings v0.0.1');

  try {
    final File arbFile = File('assets/en.arb');
    final String arbFileContentAsString = arbFile.readAsStringSync();
    final Map<String, dynamic> arbFileContentAsMap =
        json.jsonDecode(arbFileContentAsString);
  } catch (e) {
    _logger.printMessage(message: 'Error occured: $e');
  }
}
