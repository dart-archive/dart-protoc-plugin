#!/usr/bin/env dart
// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library service_generator_test;

import 'package:protoc_plugin/indenting_writer.dart';
import 'package:protoc_plugin/protoc.dart';
import 'package:test/test.dart';
import 'service_util.dart';

import 'golden_file.dart';

void main() {
  test('testServiceGenerator', () {
    var options = new GenerationOptions();
    var fd = buildFileDescriptor(
        "testpkg", "testpkg.proto", ["SomeRequest", "SomeReply"]);
    fd.service.add(buildServiceDescriptor());
    var fg = new FileGenerator(fd, options);

    var fd2 = buildFileDescriptor(
        "foo.bar", "foobar.proto", ["EmptyMessage", "AnotherReply"]);
    var fg2 = new FileGenerator(fd2, options);

    link(new GenerationOptions(), [fg, fg2]);

    var serviceWriter = new IndentingWriter();
    fg.serviceGenerators[0].generate(serviceWriter);
    expectMatchesGoldenFile(
        serviceWriter.toString(), 'test/goldens/serviceGenerator');
    expectMatchesGoldenFile(
        fg.generateJsonFile(), 'test/goldens/serviceGenerator.pb.json');
  });
}
