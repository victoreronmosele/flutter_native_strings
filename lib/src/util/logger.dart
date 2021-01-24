import 'dart:io';

import 'package:flutter_native_strings/src/models/message_factory_i.dart';
import 'package:meta/meta.dart';

class Logger implements LoggerI {
  final IOSink ioSink;

  Logger({@required this.ioSink});

  @override
  void printMessage({@required MessageFactoryI messageFactory}) {
    ioSink.writeln(messageFactory.getMessage());
  }
}

abstract class LoggerI {
  void printMessage({@required MessageFactoryI messageFactory});
}
