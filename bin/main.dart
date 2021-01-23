import 'dart:io';

import 'package:flutter_native_strings/flutter_native_strings.dart';
import 'package:flutter_native_strings/src/data/constants.dart';

void main(List<String> args) {
  final LoggerI _logger = Logger(ioSink: IOSink(stdout));

  _logger.printMessage(message: '''Welcome to ${Constants.versionNumber}''');
}
