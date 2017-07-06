// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protoc;

class EnumAlias {
  final EnumValueDescriptorProto value;
  final EnumValueDescriptorProto canonicalValue;
  EnumAlias(this.value, this.canonicalValue);
}

class EnumGenerator extends ProtobufContainer {
  final ProtobufContainer _parent;
  final String classname;
  final String fqname;
  final EnumDescriptorProto _descriptor;
  final List<EnumValueDescriptorProto> _canonicalValues =
      <EnumValueDescriptorProto>[];
  final List<EnumAlias> _aliases = <EnumAlias>[];

  EnumGenerator(EnumDescriptorProto descriptor, ProtobufContainer parent)
      : _parent = parent,
        classname = (parent == null || parent is FileGenerator)
            ? descriptor.name
            : '${parent.classname}_${descriptor.name}',
        fqname = (parent == null || parent.fqname == null)
            ? descriptor.name
            : (parent.fqname == '.'
                ? '.${descriptor.name}'
                : '${parent.fqname}.${descriptor.name}'),
        _descriptor = descriptor {
    for (EnumValueDescriptorProto value in descriptor.value) {
      EnumValueDescriptorProto canonicalValue =
          descriptor.value.firstWhere((v) => v.number == value.number);
      if (value == canonicalValue) {
        _canonicalValues.add(value);
      } else {
        _aliases.add(new EnumAlias(value, canonicalValue));
      }
    }
  }

  String get package => _parent.package;
  FileGenerator get fileGen => _parent.fileGen;

  /// Make this enum available as a field type.
  void register(GenerationContext ctx) {
    ctx.registerFieldType(fqname, this);
  }

  /// Returns a const expression that evaluates to the JSON for this message.
  /// [usage] represents the .pb.dart file where the expression will be used.
  String getJsonConstant(FileGenerator usage) {
    var name = "$classname\$json";
    if (usage.package == fileGen.package || packageImportPrefix.isEmpty) {
      return name;
    }
    return "$packageImportPrefix.$name";
  }

  void generate(IndentingWriter out) {
    out.addBlock('class ${classname} extends ProtobufEnum {', '}\n', () {
      // -----------------------------------------------------------------
      // Define enum types.
      for (EnumValueDescriptorProto val in _canonicalValues) {
        out.println('static const ${classname} ${val.name} = '
            "const ${classname}._(${val.number}, '${val.name}');");
      }
      if (!_aliases.isEmpty) {
        out.println();
        for (EnumAlias alias in _aliases) {
          out.println('static const ${classname} ${alias.value.name} ='
              ' ${alias.canonicalValue.name};');
        }
      }
      out.println();

      out.println('static const List<${classname}> values ='
          ' const <${classname}> [');
      for (EnumValueDescriptorProto val in _canonicalValues) {
        out.println('  ${val.name},');
      }
      out.println('];');
      out.println();

      out.println('static final Map<int, dynamic> _byValue ='
          ' ProtobufEnum.initByValue(values);');
      out.println('static ${classname} valueOf(int value) =>'
          ' _byValue[value] as ${classname};');
      out.addBlock('static void $checkItem($classname v) {', '}', () {
        out.println('if (v is! $classname)'
            " checkItemFailed(v, '$classname');");
      });
      out.println();

      out.println('const ${classname}._(int v, String n) '
          ': super(v, n);');
    });
  }

  /// Writes a Dart constant containing the JSON for the EnumProtoDescriptor.
  void generateConstants(IndentingWriter out) {
    var name = getJsonConstant(fileGen);
    var json = _descriptor.writeToJsonMap();

    out.print("const $name = ");
    writeJsonConst(out, json);
    out.println(";");
    out.println();
  }
}
