#!/usr/bin/env dart
// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library extension_test;

import 'package:test/test.dart';

import '../out/protos/_leading_underscores.pb.dart';

void main() {
  test('can set and read all fields', () {
    A_ message = new A_();
    message.setExtension(Leading_underscores_.p, 99);
    expect(message.getExtension(Leading_underscores_.p), 99);
    message.f = "foo";
    message.f_2 = "foo2";
    expect(message.f, "foo");
    expect(message.f_2, "foo");
    A messageA = new A();
    messageA.b = message;
    messageA.b_6 = message;
    expect(messageA.b_6, message);
    messageA.amap['foo'] = message;
    expect(messageA.amap['foo'], message);

    messageA.e = Enum_.constant;
    messageA.r.add(message);
    messageA.setExtension(Leading_underscores_.q, 100);
    expect(messageA.getExtension(Leading_underscores_.q), 100);
  });

}
