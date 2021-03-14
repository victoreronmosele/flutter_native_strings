import 'package:file/file.dart';
import 'package:flutter_native_strings/src/util/logger/logger.dart';
import 'package:meta/meta.dart';

abstract class StringResourceCreatorI {
  void createStringResource(
      {@required Map<String, dynamic> stringNameToContentMap,
      @required FileSystem fileSystem,
      @required LoggerI logger});
}
