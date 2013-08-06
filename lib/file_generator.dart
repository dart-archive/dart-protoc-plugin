// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protoc;

class FileGenerator implements ProtobufContainer {
  final FileDescriptorProto _fileDescriptor;
  final ProtobufContainer _parent;
  final GenerationContext _context;

  final List<EnumGenerator> enumGenerators = <EnumGenerator>[];
  final List<MessageGenerator> messageGenerators = <MessageGenerator>[];
  final List<ExtensionGenerator> extensionGenerators = <ExtensionGenerator>[];

  FileGenerator(this._fileDescriptor, this._parent, this._context) {
    _context.register(this);
    // Load and register all enum and message types.
    for (EnumDescriptorProto enumType in _fileDescriptor.enumType) {
      enumGenerators.add(new EnumGenerator(enumType, this, _context));
    }
    for (DescriptorProto messageType in _fileDescriptor.messageType) {
      messageGenerators.add(new MessageGenerator(messageType, this, _context));
    }
    for (FieldDescriptorProto extension in _fileDescriptor.extension) {
      extensionGenerators.add(
          new ExtensionGenerator(extension, this, _context));
    }
  }

  String get classname => '';
  String get fqname => _fileDescriptor.package == null
      ? '' : '.${_fileDescriptor.package}';

  _generatedFilePath(Path path) {
    Path withoutExtension = path.directoryPath
        .join(new Path(path.filenameWithoutExtension));
    return '${withoutExtension.toNativePath()}.pb.dart';
  }

  CodeGeneratorResponse_File generateResponse() {
    MemoryWriter writer = new MemoryWriter();
    IndentingWriter out = new IndentingWriter('  ', writer);

    generate(out);

    Path filePath = new Path(_fileDescriptor.name);
    return new CodeGeneratorResponse_File()
        ..name = _generatedFilePath(filePath)
        ..content = writer.toString();
  }

  void generate(IndentingWriter out) {

    Path filePath = new Path(_fileDescriptor.name);
    Path directoryPath = filePath.directoryPath.canonicalize();

    String className = filePath.filenameWithoutExtension.replaceAll('-', '_');
    className = '${className[0].toUpperCase()}${className.substring(1)}';

    String libraryName = className + '.pb';

    out.println(
      '///\n'
      '//  Generated code. Do not modify.\n'
      '///\n'
      'library $libraryName;\n'
      '\n'
      "import 'dart:typed_data';\n\n"
      "import 'package:protobuf/protobuf.dart';"
    );

    for (String import in _fileDescriptor.dependency) {
      Path relativeProtoPath =
          new Path(import).relativeTo(directoryPath).canonicalize();
      out.println("import '${_generatedFilePath(relativeProtoPath)}';");
    }
    out.println('');

    // Initialize Field.
    for (MessageGenerator m in messageGenerators) {
      m.initializeFields();
    }

    // Generate code.
    for (EnumGenerator e in enumGenerators) {
      e.generate(out);
    }
    for (MessageGenerator m in messageGenerators) {
      m.generate(out);
    }

    // Generate code for extensions defined at top-level using a class
    // name derived from the file name.
    if (!extensionGenerators.isEmpty) {
      // TODO(antonm): do not generate a class.
      out.addBlock('class $className {', '}\n', () {
        for (ExtensionGenerator x in extensionGenerators) {
          x.generate(out);
        }
        out.println('static void registerAllExtensions(ExtensionRegistry '
            'registry) {');
        for (ExtensionGenerator x in extensionGenerators) {
          out.println('  registry.add(${x.name});');
        }
        out.println('}');
      });
    }
  }
}

class GenerationContext {
  final GenerationOptions options;
  final Map<String, ProtobufContainer> _registry =
      <String, ProtobufContainer>{};

  GenerationContext(this.options);

  void register(ProtobufContainer container) {
    _registry[container.fqname] = container;
  }

  ProtobufContainer operator [](String fqname) => _registry[fqname];
}
