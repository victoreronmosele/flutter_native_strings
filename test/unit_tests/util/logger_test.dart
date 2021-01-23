import 'dart:io';

import 'package:flutter_native_strings/src/util/logger.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockIOSink extends Mock implements IOSink {}

void main() {
  group('Logger', () {
    MockIOSink mockIOSink;

    setUp(() {
      mockIOSink = MockIOSink();
    });

    test('prints the correct welcome message based on the version number', () {
      final String testMessage = 'Welcome to flutter_native_strings';
      final LoggerI logger = Logger(ioSink: mockIOSink);
      logger.printMessage(message: testMessage);

      verify(mockIOSink.writeln(testMessage));
    });

    tearDown(() {
      mockIOSink.close();
    });
  });
}