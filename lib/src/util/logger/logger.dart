import 'dart:io';

class Logger implements LoggerI {
  final IOSink ioSink;

  Logger({required this.ioSink});

  @override
  void printMessage({required String message}) {
    ioSink.writeln(message);
  }
}

abstract class LoggerI {
  void printMessage({required String message});
}
