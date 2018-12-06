// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:protobuf/meta.dart';
import 'package:protoc_plugin/src/dart_options.pb.dart';
import 'package:protoc_plugin/src/descriptor.pb.dart';

/// A Dart function called on each item added to a repeated list
/// to check its type and range.
const checkItem = '\$checkItem';

/// The Dart member names in a GeneratedMessage subclass for one protobuf field.
class MemberNames {
  /// The descriptor of the field these member names apply to.
  final FieldDescriptorProto descriptor;

  /// The index of this field in MessageGenerator.fieldList.
  /// The same index will be stored in FieldInfo.index.
  final int index;

  /// Identifier for generated getters/setters.
  final String fieldName;

  /// Identifier for the generated hasX() method, without braces.
  ///
  /// `null` for repeated fields.
  final String hasMethodName;

  /// Identifier for the generated clearX() method, without braces.
  ///
  /// `null` for repeated fields.
  final String clearMethodName;

  MemberNames(this.descriptor, this.index, this.fieldName,
      {this.hasMethodName, this.clearMethodName});
}

/// Move any initial underscores in [input] to the end.
///
/// According to the spec identifiers cannot start with _, but it seems to be
/// accepted by protoc.
///
/// These identifiers are private in Dart, so they have to be transformed.
String avoidInitialUnderscore(String input) {
  while (input.startsWith('_')) {
    input = '${input.substring(1)}_';
  }
  return input;
}

/// Returns [input] surrounded by single quotes and with all '$'s escaped.
String singleQuote(String input) {
  return "'${input.replaceAll(r'$', r'\$')}'";
}

/// Chooses the Dart name of an extension.
String extensionName(FieldDescriptorProto descriptor, Set<String> usedNames) {
  return _unusedMemberNames(descriptor, null, usedNames).fieldName;
}

Iterable<String> extensionSuffixes() sync* {
  yield "Ext";
  int i = 2;
  while (true) {
    yield '$i';
    i++;
  }
}

/// Replaces all characters in [imput] that are not valid in a dart identifier
/// with _.
///
/// This function does not take care of leading underscores.
String legalDartIdentifier(String imput) {
  return imput.replaceAll(new RegExp(r'[^a-zA-Z0-9$_]'), '_');
}

/// Chooses the name of the Dart class holding top-level extensions.
String extensionClassName(
    FileDescriptorProto descriptor, Set<String> usedNames) {
  String s = avoidInitialUnderscore(
      legalDartIdentifier(_fileNameWithoutExtension(descriptor)));
  String candidate = '${s[0].toUpperCase()}${s.substring(1)}';
  return disambiguateName(candidate, usedNames, extensionSuffixes());
}

String _fileNameWithoutExtension(FileDescriptorProto descriptor) {
  Uri path = new Uri.file(descriptor.name);
  String fileName = path.pathSegments.last;
  int dot = fileName.lastIndexOf(".");
  return dot == -1 ? fileName : fileName.substring(0, dot);
}

// Exception thrown when a field has an invalid 'dart_name' option.
class DartNameOptionException implements Exception {
  final String message;
  DartNameOptionException(this.message);
  String toString() => "$message";
}

/// Returns a [name] that is not contained in [usedNames] by suffixing it with
/// the first possible suffix from [suffixes].
///
/// The chosen name is added to [usedNames].
///
/// If [variants] is given, all the variants of a name must be available before
/// that name is chosen, and all the chosen variants will be added to
/// [usedNames].
/// The returned name is that, which will generate the accepted variants.
String disambiguateName(
    String name, Set<String> usedNames, Iterable<String> suffixes,
    {List<String> Function(String candidate) generateVariants}) {
  generateVariants ??= (String name) => <String>[name];

  bool allVariantsAvailable(List<String> variants) {
    return variants.every((String variant) => !usedNames.contains(variant));
  }

  String usedSuffix = '';
  List<String> candidateVariants = generateVariants(name);

  if (!allVariantsAvailable(candidateVariants)) {
    for (String suffix in suffixes) {
      candidateVariants = generateVariants('$name$suffix');
      if (allVariantsAvailable(candidateVariants)) {
        usedSuffix = suffix;
        break;
      }
    }
  }

  usedNames.addAll(candidateVariants);
  return '$name$usedSuffix';
}

Iterable<String> defaultSuffixes() sync* {
  yield '_';
  int i = 0;
  while (true) {
    yield ('_$i');
    i++;
  }
}

/// Chooses the name of the Dart class to generate for a proto message or enum.
///
/// For a nested message or enum, [parent] should be provided
/// with the name of the Dart class for the immediate parent.
String messageOrEnumClassName(String descriptorName, Set<String> usedNames,
    {String parent = ''}) {
  if (parent != '') {
    descriptorName = '${parent}_${descriptorName}';
  }
  return disambiguateName(
      avoidInitialUnderscore(descriptorName), usedNames, defaultSuffixes());
}

/// Returns the set of names reserved by the ProtobufEnum class and its
/// generated subclasses.
Set<String> get reservedEnumNames => new Set<String>()
  ..addAll(ProtobufEnum_reservedNames)
  ..addAll(_protobufEnumNames);

Iterable<String> enumSuffixes() sync* {
  String s = '_';
  while (true) {
    yield s;
    s += '_';
  }
}

/// Chooses the GeneratedMessage member names for each field.
///
/// Additional names to avoid can be supplied using [reserved].
/// (This should only be used for mixins.)
///
/// Returns a map from the field name in the .proto file to its
/// corresponding MemberNames.
///
/// Throws [DartNameOptionException] if a field has this option and
/// it's set to an invalid name.
Map<String, MemberNames> messageFieldNames(DescriptorProto descriptor,
    {Iterable<String> reserved = const []}) {
  var sorted = new List<FieldDescriptorProto>.from(descriptor.field)
    ..sort((FieldDescriptorProto a, FieldDescriptorProto b) {
      if (a.number < b.number) return -1;
      if (a.number > b.number) return 1;
      throw "multiple fields defined for tag ${a.number} in ${descriptor.name}";
    });

  // Choose indexes first, based on their position in the sorted list.
  var indexes = <String, int>{};
  for (var field in sorted) {
    var index = indexes.length;
    indexes[field.name] = index;
  }

  var existingNames = new Set<String>()
    ..addAll(reservedMemberNames)
    ..addAll(reserved);

  var memberNames = <String, MemberNames>{};

  void takeNames(MemberNames chosen) {
    memberNames[chosen.descriptor.name] = chosen;

    existingNames.add(chosen.fieldName);
    if (chosen.hasMethodName != null) {
      existingNames.add(chosen.hasMethodName);
    }
    if (chosen.clearMethodName != null) {
      existingNames.add(chosen.clearMethodName);
    }
  }

  // Handle fields with a dart_name option.
  // They have higher priority than automatically chosen names.
  // Explicitly setting a name that's already taken is a build error.
  for (var field in sorted) {
    if (_nameOption(field).isNotEmpty) {
      takeNames(_memberNamesFromOption(
          descriptor, field, indexes[field.name], existingNames));
    }
  }

  // Then do other fields.
  // They are automatically renamed until we find something unused.
  for (var field in sorted) {
    if (_nameOption(field).isEmpty) {
      var index = indexes[field.name];
      takeNames(_unusedMemberNames(field, index, existingNames));
    }
  }

  // Return a map with entries in sorted order.
  var result = <String, MemberNames>{};
  for (var field in sorted) {
    result[field.name] = memberNames[field.name];
  }
  return result;
}

/// Chooses the member names for a field that has the 'dart_name' option.
///
/// If the explicitly-set Dart name is already taken, throw an exception.
/// (Fails the build.)
MemberNames _memberNamesFromOption(DescriptorProto message,
    FieldDescriptorProto field, int index, Set<String> existingNames) {
  // TODO(skybrian): provide more context in errors (filename).
  var where = "${message.name}.${field.name}";

  void checkAvailable(String name) {
    if (existingNames.contains(name)) {
      throw new DartNameOptionException(
          "$where: dart_name option is invalid: '$name' is already used");
    }
  }

  var name = _nameOption(field);
  if (name.isEmpty) {
    throw new ArgumentError("field doesn't have dart_name option");
  }
  if (!_isDartFieldName(name)) {
    throw new DartNameOptionException("$where: dart_name option is invalid: "
        "'$name' is not a valid Dart field name");
  }
  checkAvailable(name);

  if (_isRepeated(field)) {
    return new MemberNames(field, index, name);
  }

  String hasMethod = "has${_capitalize(name)}";
  checkAvailable(hasMethod);

  String clearMethod = "clear${_capitalize(name)}";
  checkAvailable(clearMethod);

  return new MemberNames(field, index, name,
      hasMethodName: hasMethod, clearMethodName: clearMethod);
}

Iterable<String> _memberNamesSuffix(int number) sync* {
  String suffix = '_$number';
  while (true) {
    yield suffix;
    suffix = '${suffix}_$number';
  }
}

MemberNames _unusedMemberNames(
    FieldDescriptorProto field, int index, Set<String> existingNames) {
  if (_isRepeated(field)) {
    return new MemberNames(
        field,
        index,
        disambiguateName(_defaultFieldName(_fieldMethodSuffix(field)),
            existingNames, _memberNamesSuffix(field.number)));
  }

  List<String> generateNameVariants(String name) {
    return [
      _defaultFieldName(name),
      _defaultHasMethodName(name),
      _defaultClearMethodName(name)
    ];
  }

  String name = disambiguateName(_fieldMethodSuffix(field), existingNames,
      _memberNamesSuffix(field.number),
      generateVariants: generateNameVariants);
  return new MemberNames(field, index, _defaultFieldName(name),
      hasMethodName: _defaultHasMethodName(name),
      clearMethodName: _defaultClearMethodName(name));
}

/// The name to use by default for the Dart getter and setter.
/// (A suffix will be added if there is a conflict.)
String _defaultFieldName(String fieldMethodSuffix) {
  return '${fieldMethodSuffix[0].toLowerCase()}${fieldMethodSuffix.substring(1)}';
}

String _defaultHasMethodName(String fieldMethodSuffix) =>
    'has$fieldMethodSuffix';

String _defaultClearMethodName(String fieldMethodSuffix) =>
    'clear$fieldMethodSuffix';

/// The suffix to use for this field in Dart method names.
/// (It should be camelcase and begin with an uppercase letter.)
String _fieldMethodSuffix(FieldDescriptorProto field) {
  var name = _nameOption(field);
  if (name.isNotEmpty) return _capitalize(name);

  if (field.type != FieldDescriptorProto_Type.TYPE_GROUP) {
    return _underscoresToCamelCase(field.name);
  }

  // For groups, use capitalization of 'typeName' rather than 'name'.
  name = field.typeName;
  int index = name.lastIndexOf('.');
  if (index != -1) {
    name = name.substring(index + 1);
  }
  return _underscoresToCamelCase(name);
}

String _underscoresToCamelCase(s) => s.split('_').map(_capitalize).join('');

String _capitalize(s) =>
    s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

bool _isRepeated(FieldDescriptorProto field) =>
    field.label == FieldDescriptorProto_Label.LABEL_REPEATED;

String _nameOption(FieldDescriptorProto field) =>
    field.options.getExtension(Dart_options.dartName);

bool _isDartFieldName(name) => name.startsWith(_dartFieldNameExpr);

final _dartFieldNameExpr = new RegExp(r'^[a-z]\w+$');

/// Names that would collide with capitalized core Dart names as top-level
/// identifiers.
final List<String> toplevelReservedCapitalizedNames = const <String>[
  'List',
  'Function',
  'Map',
];

final List<String> reservedMemberNames = <String>[]
  ..addAll(_dartReservedWords)
  ..addAll(GeneratedMessage_reservedNames)
  ..addAll(_generatedMessageNames);

final List<String> forbiddenExtensionNames = <String>[]
  ..addAll(_dartReservedWords)
  ..addAll(GeneratedMessage_reservedNames)
  ..addAll(_generatedMessageNames);

// List of Dart language reserved words in names which cannot be used in a
// subclass of GeneratedMessage.
const List<String> _dartReservedWords = const [
  'assert',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'default',
  'do',
  'else',
  'enum',
  'extends',
  'false',
  'final',
  'finally',
  'for',
  'if',
  'in',
  'is',
  'new',
  'null',
  'rethrow',
  'return',
  'super',
  'switch',
  'this',
  'throw',
  'true',
  'try',
  'var',
  'void',
  'while',
  'with'
];

// List of names used in the generated message classes.
//
// This is in addition to GeneratedMessage_reservedNames, which are names from
// the base GeneratedMessage class determined by reflection.
const _generatedMessageNames = const <String>[
  'create',
  'createRepeated',
  'getDefault',
  'List',
  checkItem
];

// List of names used in the generated enum classes.
//
// This is in addition to ProtobufEnum_reservedNames, which are names from the
// base ProtobufEnum class determined by reflection.
const _protobufEnumNames = const <String>[
  'List',
  'valueOf',
  'values',
  checkItem
];
