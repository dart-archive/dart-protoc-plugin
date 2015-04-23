library protoc;

import 'dart:async';
import 'dart:io';

import 'package:protobuf/protobuf.dart';
import 'package:path/path.dart' as path;

import 'src/descriptor.pb.dart';
import 'src/plugin.pb.dart';

part 'src/protoc/code_generator.dart';
part 'src/protoc/enum_generator.dart';
part 'src/protoc/exceptions.dart';
part 'src/protoc/extension_generator.dart';
part 'src/protoc/file_generator.dart';
part 'src/protoc/indenting_writer.dart';
part 'src/protoc/message_generator.dart';
part 'src/protoc/options.dart';
part 'src/protoc/output_config.dart';
part 'src/protoc/protobuf_field.dart';
part 'src/protoc/writer.dart';
