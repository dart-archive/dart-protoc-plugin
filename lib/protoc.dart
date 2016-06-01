library protoc;

import 'dart:async';
import 'dart:io';

import 'package:protobuf/meta.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protobuf/mixins_meta.dart';
import 'package:path/path.dart' as path;

import 'src/descriptor.pb.dart';
import 'src/plugin.pb.dart';
import 'src/dart_options.pb.dart';

import 'const_generator.dart' show writeJsonConst;
import 'indenting_writer.dart' show IndentingWriter;

part 'src/protoc/base_type.dart';
part 'src/protoc/client_generator.dart';
part 'src/protoc/code_generator.dart';
part 'src/protoc/enum_generator.dart';
part 'src/protoc/extension_generator.dart';
part 'src/protoc/file_generator.dart';
part 'src/protoc/linker.dart';
part 'src/protoc/message_generator.dart';
part 'src/protoc/options.dart';
part 'src/protoc/output_config.dart';
part 'src/protoc/protobuf_field.dart';
part 'src/protoc/service_generator.dart';
