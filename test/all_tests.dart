#!/usr/bin/env dart
// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library protoc_plugin_all_tests;

import 'bazel_test.dart' as bazel;
import 'client_generator_test.dart' as client_generator;
import 'const_generator_test.dart' as const_generator;
import 'enum_generator_test.dart' as enum_generator;
import 'extension_test.dart' as extension;
import 'file_generator_test.dart' as file_generator;
import 'generated_message_test.dart' as generated_message;
import 'hash_code_test.dart' as hash_code;
import 'indenting_writer_test.dart' as indenting_writer;
import 'import_test.dart' as import_prefix;
import 'json_test.dart' as json;
import 'map_test.dart' as map;
import 'message_generator_test.dart' as message_generator;
import 'message_test.dart' as message;
import 'mixin_test.dart' as mixin_test;
import 'names_test.dart' as names;
import 'protoc_options_test.dart' as protoc_options;
import 'repeated_field_test.dart' as repeated_field;
import 'service_test.dart' as service;
import 'service_generator_test.dart' as service_generator;
import 'unknown_field_set_test.dart' as unknown_field_set;
import 'validate_fail_test.dart' as validate_fail;
import 'wire_format_test.dart' as wire_format;

void main() {
  bazel.main();
  client_generator.main();
  const_generator.main();
  enum_generator.main();
  extension.main();
  file_generator.main();
  generated_message.main();
  hash_code.main();
  indenting_writer.main();
  import_prefix.main();
  json.main();
  map.main();
  message_generator.main();
  message.main();
  mixin_test.main();
  names.main();
  protoc_options.main();
  repeated_field.main();
  service.main();
  service_generator.main();
  unknown_field_set.main();
  validate_fail.main();
  wire_format.main();
}
