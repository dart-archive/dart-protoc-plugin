///
//  Generated code. Do not modify.
///
// @ignoreProblemForFile non_constant_identifier_names
// @ignoreProblemForFile library_prefixes
library dart_options_dart_options;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;
import 'package:protobuf/protobuf.dart';

class DartMixin extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DartMixin')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'importFrom', PbFieldType.OS)
    ..a/*<String>*/(3, 'parent', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DartMixin() : super();
  DartMixin.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DartMixin.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DartMixin clone() => new DartMixin()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DartMixin create() => new DartMixin();
  static PbList<DartMixin> createRepeated() => new PbList<DartMixin>();
  static DartMixin getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDartMixin();
    return _defaultInstance;
  }
  static DartMixin _defaultInstance;
  static void $checkItem(DartMixin v) {
    if (v is !DartMixin) checkItemFailed(v, 'DartMixin');
  }

  String get name => $_get(0, 1, '');
  set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get importFrom => $_get(1, 2, '');
  set importFrom(String v) { $_setString(1, 2, v); }
  bool hasImportFrom() => $_has(1, 2);
  void clearImportFrom() => clearField(2);

  String get parent => $_get(2, 3, '');
  set parent(String v) { $_setString(2, 3, v); }
  bool hasParent() => $_has(2, 3);
  void clearParent() => clearField(3);
}

class _ReadonlyDartMixin extends DartMixin with ReadonlyMessageMixin {}

class Imports extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Imports')
    ..pp/*<DartMixin>*/(1, 'mixins', PbFieldType.PM, DartMixin.$checkItem, DartMixin.create)
    ..hasRequiredFields = false
  ;

  Imports() : super();
  Imports.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Imports.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Imports clone() => new Imports()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Imports create() => new Imports();
  static PbList<Imports> createRepeated() => new PbList<Imports>();
  static Imports getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyImports();
    return _defaultInstance;
  }
  static Imports _defaultInstance;
  static void $checkItem(Imports v) {
    if (v is !Imports) checkItemFailed(v, 'Imports');
  }

  List<DartMixin> get mixins => $_get(0, 1, null);
}

class _ReadonlyImports extends Imports with ReadonlyMessageMixin {}

class Dart_options {
  static final Extension imports = new Extension<Imports>('FileOptions', 'imports', 28125061, PbFieldType.OM, Imports.getDefault, Imports.create);
  static final Extension defaultMixin = new Extension<String>('FileOptions', 'defaultMixin', 96128839, PbFieldType.OS);
  static final Extension mixin = new Extension<String>('MessageOptions', 'mixin', 96128839, PbFieldType.OS);
  static final Extension overrideGetter = new Extension<bool>('FieldOptions', 'overrideGetter', 28205290, PbFieldType.OB);
  static final Extension overrideSetter = new Extension<bool>('FieldOptions', 'overrideSetter', 28937366, PbFieldType.OB);
  static final Extension overrideHasMethod = new Extension<bool>('FieldOptions', 'overrideHasMethod', 28937461, PbFieldType.OB);
  static final Extension overrideClearMethod = new Extension<bool>('FieldOptions', 'overrideClearMethod', 28907907, PbFieldType.OB);
  static final Extension dartName = new Extension<String>('FieldOptions', 'dartName', 28700919, PbFieldType.OS);
  static void registerAllExtensions(ExtensionRegistry registry) {
    registry.add(imports);
    registry.add(defaultMixin);
    registry.add(mixin);
    registry.add(overrideGetter);
    registry.add(overrideSetter);
    registry.add(overrideHasMethod);
    registry.add(overrideClearMethod);
    registry.add(dartName);
  }
}

