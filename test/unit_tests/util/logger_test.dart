import 'dart:io';

import 'package:flutter_native_strings/src/util/logger/logger.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockIOSink extends Mock implements IOSink {}

void main() {
  group(Logger, () {
    late MockIOSink mockIOSink;

    setUp(() {
      mockIOSink = MockIOSink();
    });

    test('printMessage() prints the correct message', () {
      final String testMessage = 'Welcome to flutter_native_strings';

      final LoggerI logger = Logger(ioSink: mockIOSink);
      logger.printMessage(message: testMessage);

      verify(mockIOSink.writeln(testMessage));
    });
  });
}
