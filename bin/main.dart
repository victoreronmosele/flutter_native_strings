import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_native_strings/flutter_native_strings.dart';
import 'dart:io'; //show stdout, IOSink; ///Showing only these so the File

import 'package:flutter_native_strings/src/util/logger/logger.dart';
import 'package:flutter_native_strings/src/util/string_resource_creator/android_string_resource_creator.dart';
import 'package:flutter_native_strings/src/util/string_resource_creator/string_resource_creator_i.dart';

main(List<String> args) {
  final LoggerI logger = Logger(ioSink: IOSink(stdout));
  final StringResourceCreatorI androidStringResourceCreator =
      AndroidStringResourceCreator();
  final FileSystem fileSystem = LocalFileSystem();
  final String arbFilePath = 'assets/en.arb';

  FlutterNativeStrings().generateNativeStrings(
    logger: logger,
    fileSystem: fileSystem,
    arbFilePath: arbFilePath,
    androidStringResourceCreator: androidStringResourceCreator,
  );
}
