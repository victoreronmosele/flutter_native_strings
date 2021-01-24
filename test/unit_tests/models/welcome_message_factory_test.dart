import 'package:flutter_native_strings/src/data/constants.dart';
import 'package:flutter_native_strings/src/models/welcome_message_factory.dart';
import 'package:test/test.dart';

void main() {
  group(WelcomeMessageFactory, () {
    test('getMessage() returns the correct welcome message', () {
      final WelcomeMessageFactory welcomeMessageFactory =
          WelcomeMessageFactory();

      expect(welcomeMessageFactory.getMessage(),
          'Welcome to Flutter Native Strings ${Constants.versionNumber}');
    });
  });
}
