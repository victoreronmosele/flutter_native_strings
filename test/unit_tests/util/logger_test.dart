import 'dart:io';

import 'package:flutter_native_strings/src/models/message_factory_i.dart';
import 'package:flutter_native_strings/src/util/logger.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockIOSink extends Mock implements IOSink {}

class MockMessageFactory extends Mock implements MessageFactoryI {}

void main() {
  group(Logger, () {
    MockIOSink mockIOSink;
    MockMessageFactory mockMessageFactory;

    setUp(() {
      mockIOSink = MockIOSink();
      mockMessageFactory = MockMessageFactory();
    });

    test('printMessage() prints the correct message', () {
      final String testMessage = 'Welcome to flutter_native_strings';

      when(mockMessageFactory.getMessage()).thenReturn(testMessage);

      final LoggerI logger = Logger(ioSink: mockIOSink);
      logger.printMessage(messageFactory: mockMessageFactory);

      verify(mockIOSink.writeln(testMessage));
    });

    tearDown(() {
      mockIOSink.close();
    });
  });
}
