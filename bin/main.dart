import 'dart:io';

import 'package:flutter_native_strings/flutter_native_strings.dart';

void main(List<String> args) {
  final LoggerI _logger = Logger(ioSink: IOSink(stdout));

  _logger.printMessage(message: 'Welcome to Flutter Native Strings v0.0.1');

  try {
    final File file = File('assets/en.arb');
  } catch (e) {
    _logger.printMessage(message: 'Error occured: $e');
  }
}
