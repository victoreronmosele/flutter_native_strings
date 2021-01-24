import 'package:flutter_native_strings/src/data/constants.dart';
import 'package:flutter_native_strings/src/models/message_factory_i.dart';

class WelcomeMessageFactory implements MessageFactoryI {
  @override
  String getMessage() {
    return 'Welcome to Flutter Native Strings ${Constants.versionNumber}';
  }
}
