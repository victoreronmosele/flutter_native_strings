import 'dart:io';

import 'package:flutter_native_strings/flutter_native_strings.dart';
import 'package:flutter_native_strings/src/models/welcome_message_factory.dart';

void main(List<String> args) {
  final LoggerI _logger = Logger(ioSink: IOSink(stdout));

  _logger.printMessage(messageFactory: WelcomeMessageFactory());
}
