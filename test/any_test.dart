// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:protobuf/protobuf.dart';
import 'package:test/test.dart';

import '../out/protos/google/protobuf/any.pb.dart';
import '../out/protos/service.pb.dart';
import '../out/protos/using_any.pb.dart';

void main() {
  test('pack -> unpack', () {
    Any any = Any.pack(new SearchRequest()..query = 'hest');
    expect(any.typeUrl, 'type.googleapis.com/SearchRequest');
    Any any1 = Any.pack(new SearchRequest()..query = 'hest1',
        typeUrlPrefix: 'example.com');
    expect(any1.typeUrl, 'example.com/SearchRequest');
    SearchRequest searchRequest = any.unpack(new SearchRequest());
    expect(searchRequest.query, 'hest');
    SearchRequest searchRequest1 = any1.unpack(new SearchRequest());
    expect(searchRequest1.query, 'hest1');
    expect(() {
      any.unpack(new SearchResponse());
    }, throwsA(const TypeMatcher<InvalidProtocolBufferException>()));
  });

  test('nested any', () {
    Any any = Any.pack(Any.pack(new SearchRequest()..query = 'hest'));
    expect(any.typeUrl, 'type.googleapis.com/google.protobuf.Any');
    expect(any.unpack(new Any()).unpack(new SearchRequest()).query, 'hest');
  });

  test('using any', () {
    Any any = Any.pack(new SearchRequest()..query = 'hest');
    Any any1 = Any.pack(new SearchRequest()..query = 'hest1');
    Any any2 = Any.pack(new SearchRequest()..query = 'hest2');
    TestAny testAny = TestAny()
      ..anyValue = any
      ..repeatedAnyValue.addAll(<Any>[any1, any2]);
    TestAny testAnyFromBuffer = TestAny.fromBuffer(testAny.writeToBuffer());
    expect(
        testAnyFromBuffer.anyValue.unpack(new SearchRequest()).query, 'hest');
    expect(
        testAnyFromBuffer.repeatedAnyValue[0].unpack(new SearchRequest()).query,
        'hest1');
    expect(
        testAnyFromBuffer.repeatedAnyValue[1].unpack(new SearchRequest()).query,
        'hest2');
  });
}
