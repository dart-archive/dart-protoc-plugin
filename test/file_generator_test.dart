#!/usr/bin/env dart
// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library file_generator_test;

import 'package:protoc_plugin/indenting_writer.dart';
import 'package:protoc_plugin/src/descriptor.pb.dart';
import 'package:protoc_plugin/src/plugin.pb.dart';
import 'package:protoc_plugin/protoc.dart';
import 'package:test/test.dart';

FileDescriptorProto buildFileDescriptor(
    {phoneNumber: true, topLevelEnum: false}) {
  FileDescriptorProto fd = new FileDescriptorProto()..name = 'test';

  if (topLevelEnum) {
    fd.enumType.add(new EnumDescriptorProto()
      ..name = 'PhoneType'
      ..value.addAll([
        new EnumValueDescriptorProto()
          ..name = 'MOBILE'
          ..number = 0,
        new EnumValueDescriptorProto()
          ..name = 'HOME'
          ..number = 1,
        new EnumValueDescriptorProto()
          ..name = 'WORK'
          ..number = 2,
        new EnumValueDescriptorProto()
          ..name = 'BUSINESS'
          ..number = 2
      ]));
  }

  if (phoneNumber) {
    fd.messageType.add(new DescriptorProto()
      ..name = 'PhoneNumber'
      ..field.addAll([
        // required string number = 1;
        new FieldDescriptorProto()
          ..name = 'number'
          ..number = 1
          ..label = FieldDescriptorProto_Label.LABEL_REQUIRED
          ..type = FieldDescriptorProto_Type.TYPE_STRING,
        // optional int32 type = 2;
        // OR
        // optional PhoneType type = 2;
        new FieldDescriptorProto()
          ..name = 'type'
          ..number = 2
          ..label = FieldDescriptorProto_Label.LABEL_OPTIONAL
          ..type = topLevelEnum
              ? FieldDescriptorProto_Type.TYPE_ENUM
              : FieldDescriptorProto_Type.TYPE_INT32
          ..typeName = topLevelEnum ? '.PhoneType' : '',
        // optional string name = 3 [default = "$"];
        new FieldDescriptorProto()
          ..name = 'name'
          ..number = 3
          ..label = FieldDescriptorProto_Label.LABEL_OPTIONAL
          ..type = FieldDescriptorProto_Type.TYPE_STRING
          ..defaultValue = r'$'
      ]));
  }

  return fd;
}

void main() {
  test('FileGenerator outputs a .pb.dart file for a proto with one message',
      () {
    // NOTE: Below > 80 cols because it is matching generated code > 80 cols.
    String expected = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class PhoneNumber extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PhoneNumber')
    ..aQS(1, 'number')
    ..a<int>(2, 'type', PbFieldType.O3)
    ..a<String>(3, 'name', PbFieldType.OS, '\$')
  ;

  PhoneNumber() : super();
  PhoneNumber.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PhoneNumber.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PhoneNumber clone() => new PhoneNumber()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PhoneNumber create() => new PhoneNumber();
  static PbList<PhoneNumber> createRepeated() => new PbList<PhoneNumber>();
  static PhoneNumber getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPhoneNumber();
    return _defaultInstance;
  }
  static PhoneNumber _defaultInstance;
  static void $checkItem(PhoneNumber v) {
    if (v is! PhoneNumber) checkItemFailed(v, 'PhoneNumber');
  }

  String get number => $_getS(0, '');
  set number(String v) { $_setString(0, v); }
  bool hasNumber() => $_has(0);
  void clearNumber() => clearField(1);

  int get type => $_get(1, 0);
  set type(int v) { $_setUnsignedInt32(1, v); }
  bool hasType() => $_has(1);
  void clearType() => clearField(2);

  String get name => $_getS(2, '\$');
  set name(String v) { $_setString(2, v); }
  bool hasName() => $_has(2);
  void clearName() => clearField(3);
}

class _ReadonlyPhoneNumber extends PhoneNumber with ReadonlyMessageMixin {}

''';
    FileDescriptorProto fd = buildFileDescriptor();
    var options = parseGenerationOptions(
        new CodeGeneratorRequest(), new CodeGeneratorResponse());
    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);
    expect(fg.generateMainFile(), expected);
  });

  test('FileGenerator outputs a pbjson.dart file for a proto with one message',
      () {
    var expected = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test_pbjson;

const PhoneNumber$json = const {
  '1': 'PhoneNumber',
  '2': const [
    const {'1': 'number', '3': 1, '4': 2, '5': 9},
    const {'1': 'type', '3': 2, '4': 1, '5': 5, '6': ''},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '7': r'$'},
  ],
};

''';
    FileDescriptorProto fd = buildFileDescriptor();
    var options = parseGenerationOptions(
        new CodeGeneratorRequest(), new CodeGeneratorResponse());
    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);
    expect(fg.generateJsonFile(), expected);
  });

  test('FileGenerator generates files for a top-level enum', () {
    // NOTE: Below > 80 cols because it is matching generated code > 80 cols.

    String expected = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

export 'test.pbenum.dart';

''';

    String expectedEnum = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test_pbenum;

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart';

class PhoneType extends ProtobufEnum {
  static const PhoneType MOBILE = const PhoneType._(0, 'MOBILE');
  static const PhoneType HOME = const PhoneType._(1, 'HOME');
  static const PhoneType WORK = const PhoneType._(2, 'WORK');

  static const PhoneType BUSINESS = WORK;

  static const List<PhoneType> values = const <PhoneType> [
    MOBILE,
    HOME,
    WORK,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PhoneType valueOf(int value) => _byValue[value] as PhoneType;
  static void $checkItem(PhoneType v) {
    if (v is! PhoneType) checkItemFailed(v, 'PhoneType');
  }

  const PhoneType._(int v, String n) : super(v, n);
}

''';

    FileDescriptorProto fd =
        buildFileDescriptor(phoneNumber: false, topLevelEnum: true);
    var options = parseGenerationOptions(
        new CodeGeneratorRequest(), new CodeGeneratorResponse());

    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);
    expect(fg.generateMainFile(), expected);
    expect(fg.generateEnumFile(), expectedEnum);
  });

  test('FileGenerator generates a .pbjson.dart file for a top-level enum', () {
    String expected = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test_pbjson;

const PhoneType$json = const {
  '1': 'PhoneType',
  '2': const [
    const {'1': 'MOBILE', '2': 0},
    const {'1': 'HOME', '2': 1},
    const {'1': 'WORK', '2': 2},
    const {'1': 'BUSINESS', '2': 2},
  ],
};

''';

    FileDescriptorProto fd =
        buildFileDescriptor(phoneNumber: false, topLevelEnum: true);
    var options = parseGenerationOptions(
        new CodeGeneratorRequest(), new CodeGeneratorResponse());

    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);
    expect(fg.generateJsonFile(), expected);
  });

  test('FileGenerator outputs library for a .proto in a package', () {
    String expected = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library pb_library_test;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

''';
    FileDescriptorProto fd = buildFileDescriptor();
    fd.package = "pb_library";
    var options = parseGenerationOptions(
        new CodeGeneratorRequest(), new CodeGeneratorResponse());

    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);

    var writer = new IndentingWriter();
    fg.writeMainHeader(writer);
    expect(writer.toString(), expected);
  });

  test('FileGenerator outputs a fixnum import when needed', () {
    String expected = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

''';
    FileDescriptorProto fd = new FileDescriptorProto()
      ..name = 'test'
      ..messageType.add(new DescriptorProto()
        ..name = 'Count'
        ..field.addAll([
          new FieldDescriptorProto()
            ..name = 'count'
            ..number = 1
            ..type = FieldDescriptorProto_Type.TYPE_INT64
        ]));

    var options = parseGenerationOptions(
        new CodeGeneratorRequest(), new CodeGeneratorResponse());

    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);

    var writer = new IndentingWriter();
    fg.writeMainHeader(writer);
    expect(writer.toString(), expected);
  });

  test('FileGenerator outputs files for a service', () {
    String expectedClient = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test;

import 'dart:async';
// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class Empty extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Empty')
    ..hasRequiredFields = false
  ;

  Empty() : super();
  Empty.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Empty.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Empty clone() => new Empty()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Empty create() => new Empty();
  static PbList<Empty> createRepeated() => new PbList<Empty>();
  static Empty getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEmpty();
    return _defaultInstance;
  }
  static Empty _defaultInstance;
  static void $checkItem(Empty v) {
    if (v is! Empty) checkItemFailed(v, 'Empty');
  }
}

class _ReadonlyEmpty extends Empty with ReadonlyMessageMixin {}

class TestApi {
  RpcClient _client;
  TestApi(this._client);

  Future<Empty> ping(ClientContext ctx, Empty request) {
    var emptyResponse = new Empty();
    return _client.invoke(ctx, 'Test', 'Ping', request, emptyResponse);
  }
}

''';

    String expectedServer = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'test.pb.dart';
import 'test.pbjson.dart';

export 'test.pb.dart';

abstract class TestServiceBase extends GeneratedService {
  Future<Empty> ping(ServerContext ctx, Empty request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'Ping': return new Empty();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'Ping': return this.ping(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Test$json;
  Map<String, Map<String, dynamic>> get $messageJson => Test$messageJson;
}

''';

    DescriptorProto empty = new DescriptorProto()..name = "Empty";

    ServiceDescriptorProto sd = new ServiceDescriptorProto()
      ..name = 'Test'
      ..method.add(new MethodDescriptorProto()
        ..name = 'Ping'
        ..inputType = '.Empty'
        ..outputType = '.Empty');

    FileDescriptorProto fd = new FileDescriptorProto()
      ..name = 'test'
      ..messageType.add(empty)
      ..service.add(sd);

    var options = parseGenerationOptions(
        new CodeGeneratorRequest(), new CodeGeneratorResponse());

    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);

    var writer = new IndentingWriter();
    fg.writeMainHeader(writer);
    expect(fg.generateMainFile(), expectedClient);
    expect(fg.generateServerFile(), expectedServer);
  });

  test('FileGenerator does not output legacy service stubs if gRPC is selected',
      () {
    String expectedClient = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class Empty extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Empty')
    ..hasRequiredFields = false
  ;

  Empty() : super();
  Empty.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Empty.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Empty clone() => new Empty()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Empty create() => new Empty();
  static PbList<Empty> createRepeated() => new PbList<Empty>();
  static Empty getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEmpty();
    return _defaultInstance;
  }
  static Empty _defaultInstance;
  static void $checkItem(Empty v) {
    if (v is! Empty) checkItemFailed(v, 'Empty');
  }
}

class _ReadonlyEmpty extends Empty with ReadonlyMessageMixin {}

''';

    DescriptorProto empty = new DescriptorProto()..name = "Empty";

    ServiceDescriptorProto sd = new ServiceDescriptorProto()
      ..name = 'Test'
      ..method.add(new MethodDescriptorProto()
        ..name = 'Ping'
        ..inputType = '.Empty'
        ..outputType = '.Empty');

    FileDescriptorProto fd = new FileDescriptorProto()
      ..name = 'test'
      ..messageType.add(empty)
      ..service.add(sd);

    var options = new GenerationOptions(useGrpc: true);

    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);

    var writer = new IndentingWriter();
    fg.writeMainHeader(writer);
    expect(fg.generateMainFile(), expectedClient);
  });

  test('FileGenerator outputs gRPC stubs if gRPC is selected', () {
    final expectedGrpc = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'test.pb.dart';
export 'test.pb.dart';

class TestClient extends Client {
  static final _$unary = new ClientMethod<Input, Output>(
      '/Test/Unary',
      (Input value) => value.writeToBuffer(),
      (List<int> value) => new Output.fromBuffer(value));
  static final _$clientStreaming = new ClientMethod<Input, Output>(
      '/Test/ClientStreaming',
      (Input value) => value.writeToBuffer(),
      (List<int> value) => new Output.fromBuffer(value));
  static final _$serverStreaming = new ClientMethod<Input, Output>(
      '/Test/ServerStreaming',
      (Input value) => value.writeToBuffer(),
      (List<int> value) => new Output.fromBuffer(value));
  static final _$bidirectional = new ClientMethod<Input, Output>(
      '/Test/Bidirectional',
      (Input value) => value.writeToBuffer(),
      (List<int> value) => new Output.fromBuffer(value));

  TestClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Output> unary(Input request, {CallOptions options}) {
    final call = $createCall(_$unary, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<Output> clientStreaming(Stream<Input> request,
      {CallOptions options}) {
    final call = $createCall(_$clientStreaming, request, options: options);
    return new ResponseFuture(call);
  }

  ResponseStream<Output> serverStreaming(Input request, {CallOptions options}) {
    final call = $createCall(
        _$serverStreaming, new Stream.fromIterable([request]),
        options: options);
    return new ResponseStream(call);
  }

  ResponseStream<Output> bidirectional(Stream<Input> request,
      {CallOptions options}) {
    final call = $createCall(_$bidirectional, request, options: options);
    return new ResponseStream(call);
  }
}

abstract class TestServiceBase extends Service {
  String get $name => 'Test';

  TestServiceBase() {
    $addMethod(new ServiceMethod<Input, Output>(
        'Unary',
        unary_Pre,
        false,
        false,
        (List<int> value) => new Input.fromBuffer(value),
        (Output value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<Input, Output>(
        'ClientStreaming',
        clientStreaming,
        true,
        false,
        (List<int> value) => new Input.fromBuffer(value),
        (Output value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<Input, Output>(
        'ServerStreaming',
        serverStreaming_Pre,
        false,
        true,
        (List<int> value) => new Input.fromBuffer(value),
        (Output value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<Input, Output>(
        'Bidirectional',
        bidirectional,
        true,
        true,
        (List<int> value) => new Input.fromBuffer(value),
        (Output value) => value.writeToBuffer()));
  }

  Future<Output> unary_Pre(ServiceCall call, Future request) async {
    return unary(call, await request);
  }

  Stream<Output> serverStreaming_Pre(ServiceCall call, Future request) async* {
    yield* serverStreaming(call, (await request) as Input);
  }

  Future<Output> unary(ServiceCall call, Input request);
  Future<Output> clientStreaming(ServiceCall call, Stream<Input> request);
  Stream<Output> serverStreaming(ServiceCall call, Input request);
  Stream<Output> bidirectional(ServiceCall call, Stream<Input> request);
}
''';

    final input = new DescriptorProto()..name = 'Input';
    final output = new DescriptorProto()..name = 'Output';

    final unary = new MethodDescriptorProto()
      ..name = 'Unary'
      ..inputType = '.Input'
      ..outputType = '.Output'
      ..clientStreaming = false
      ..serverStreaming = false;
    final clientStreaming = new MethodDescriptorProto()
      ..name = 'ClientStreaming'
      ..inputType = '.Input'
      ..outputType = '.Output'
      ..clientStreaming = true
      ..serverStreaming = false;
    final serverStreaming = new MethodDescriptorProto()
      ..name = 'ServerStreaming'
      ..inputType = '.Input'
      ..outputType = '.Output'
      ..clientStreaming = false
      ..serverStreaming = true;
    final bidirectional = new MethodDescriptorProto()
      ..name = 'Bidirectional'
      ..inputType = '.Input'
      ..outputType = '.Output'
      ..clientStreaming = true
      ..serverStreaming = true;

    ServiceDescriptorProto sd = new ServiceDescriptorProto()
      ..name = 'Test'
      ..method.addAll([unary, clientStreaming, serverStreaming, bidirectional]);

    FileDescriptorProto fd = new FileDescriptorProto()
      ..name = 'test'
      ..messageType.addAll([input, output])
      ..service.add(sd);

    var options = new GenerationOptions(useGrpc: true);

    FileGenerator fg = new FileGenerator(fd, options);
    link(options, [fg]);

    var writer = new IndentingWriter();
    fg.writeMainHeader(writer);
    expect(fg.generateGrpcFile(), expectedGrpc);
  });

  test('FileGenerator generates imports for .pb.dart files', () {
    // NOTE: Below > 80 cols because it is matching generated code > 80 cols.
    String expected = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

import 'package1.pb.dart' as $p1;
import 'package2.pb.dart' as $p2;

class M extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('M')
    ..a<M>(1, 'm', PbFieldType.OM, M.getDefault, M.create)
    ..a<$p1.M>(2, 'm1', PbFieldType.OM, $p1.M.getDefault, $p1.M.create)
    ..a<$p2.M>(3, 'm2', PbFieldType.OM, $p2.M.getDefault, $p2.M.create)
    ..hasRequiredFields = false
  ;

  M() : super();
  M.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  M.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  M clone() => new M()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static M create() => new M();
  static PbList<M> createRepeated() => new PbList<M>();
  static M getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyM();
    return _defaultInstance;
  }
  static M _defaultInstance;
  static void $checkItem(M v) {
    if (v is! M) checkItemFailed(v, 'M');
  }

  M get m => $_getN(0);
  set m(M v) { setField(1, v); }
  bool hasM() => $_has(0);
  void clearM() => clearField(1);

  $p1.M get m1 => $_getN(1);
  set m1($p1.M v) { setField(2, v); }
  bool hasM1() => $_has(1);
  void clearM1() => clearField(2);

  $p2.M get m2 => $_getN(2);
  set m2($p2.M v) { setField(3, v); }
  bool hasM2() => $_has(2);
  void clearM2() => clearField(3);
}

class _ReadonlyM extends M with ReadonlyMessageMixin {}

''';

    var expectedJson = r'''
///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library test_pbjson;

const M$json = const {
  '1': 'M',
  '2': const [
    const {'1': 'm', '3': 1, '4': 1, '5': 11, '6': '.M'},
    const {'1': 'm1', '3': 2, '4': 1, '5': 11, '6': '.p1.M'},
    const {'1': 'm2', '3': 3, '4': 1, '5': 11, '6': '.p2.M'},
  ],
};

''';

    // This defines three .proto files package1.proto, package2.proto and
    // test.proto with the following content:
    //
    // package1.proto:
    // ---------------
    // package p1;
    // message M {
    //   optional M m = 2;
    // }
    //
    // package2.proto:
    // ---------------
    // package p2;
    // message M {
    //   optional M m = 2;
    // }
    //
    // test.proto:
    // ---------------
    // package test;
    // import "package1.proto";
    // import "package2.proto";
    // message M {
    //   optional M m = 1;
    //   optional p1.M m1 = 2;
    //   optional p2.M m2 = 3;
    // }

    // Description of package1.proto.
    DescriptorProto md1 = new DescriptorProto()
      ..name = 'M'
      ..field.addAll([
        // optional M m = 1;
        new FieldDescriptorProto()
          ..name = 'm'
          ..number = 1
          ..label = FieldDescriptorProto_Label.LABEL_OPTIONAL
          ..type = FieldDescriptorProto_Type.TYPE_MESSAGE
          ..typeName = ".p1.M",
      ]);
    FileDescriptorProto fd1 = new FileDescriptorProto()
      ..package = 'p1'
      ..name = 'package1.proto'
      ..messageType.add(md1);

    // Description of package1.proto.
    DescriptorProto md2 = new DescriptorProto()
      ..name = 'M'
      ..field.addAll([
        // optional M m = 1;
        new FieldDescriptorProto()
          ..name = 'x'
          ..number = 1
          ..label = FieldDescriptorProto_Label.LABEL_OPTIONAL
          ..type = FieldDescriptorProto_Type.TYPE_MESSAGE
          ..typeName = ".p2.M",
      ]);
    FileDescriptorProto fd2 = new FileDescriptorProto()
      ..package = 'p2'
      ..name = 'package2.proto'
      ..messageType.add(md2);

    // Description of test.proto.
    DescriptorProto md = new DescriptorProto()
      ..name = 'M'
      ..field.addAll([
        // optional M m = 1;
        new FieldDescriptorProto()
          ..name = 'm'
          ..number = 1
          ..label = FieldDescriptorProto_Label.LABEL_OPTIONAL
          ..type = FieldDescriptorProto_Type.TYPE_MESSAGE
          ..typeName = ".M",
        // optional p1.M m1 = 2;
        new FieldDescriptorProto()
          ..name = 'm1'
          ..number = 2
          ..label = FieldDescriptorProto_Label.LABEL_OPTIONAL
          ..type = FieldDescriptorProto_Type.TYPE_MESSAGE
          ..typeName = ".p1.M",
        // optional p2.M m2 = 3;
        new FieldDescriptorProto()
          ..name = 'm2'
          ..number = 3
          ..label = FieldDescriptorProto_Label.LABEL_OPTIONAL
          ..type = FieldDescriptorProto_Type.TYPE_MESSAGE
          ..typeName = ".p2.M",
      ]);
    FileDescriptorProto fd = new FileDescriptorProto()
      ..name = 'test.proto'
      ..messageType.add(md);
    fd.dependency.addAll(['package1.proto', 'package2.proto']);
    var request = new CodeGeneratorRequest();
    var response = new CodeGeneratorResponse();
    var options = parseGenerationOptions(request, response);

    FileGenerator fg = new FileGenerator(fd, options);
    link(options,
        [fg, new FileGenerator(fd1, options), new FileGenerator(fd2, options)]);
    expect(fg.generateMainFile(), expected);
    expect(fg.generateJsonFile(), expectedJson);
  });
}
