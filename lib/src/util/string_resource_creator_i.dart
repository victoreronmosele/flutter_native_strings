import 'package:flutter_native_strings/src/util/logger.dart';
import 'package:meta/meta.dart';

abstract class StringResourceCreatorI {
  void createStringResource(
      {@required Map<String, dynamic> stringNameToContentMap,
      @required LoggerI logger});
}
