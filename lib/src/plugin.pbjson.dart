///
//  Generated code. Do not modify.
///
library proto2.compiler_plugin_pbjson;

const CodeGeneratorRequest$json = const {
  '1': 'CodeGeneratorRequest',
  '2': const [
    const {'1': 'file_to_generate', '3': 1, '4': 3, '5': 9},
    const {'1': 'parameter', '3': 2, '4': 1, '5': 9},
    const {'1': 'proto_file', '3': 15, '4': 3, '5': 11, '6': '.proto2.FileDescriptorProto'},
  ],
};

const CodeGeneratorResponse$json = const {
  '1': 'CodeGeneratorResponse',
  '2': const [
    const {'1': 'error', '3': 1, '4': 1, '5': 9},
    const {'1': 'file', '3': 15, '4': 3, '5': 11, '6': '.proto2.compiler.CodeGeneratorResponse.File'},
  ],
  '3': const [CodeGeneratorResponse_File$json],
};

const CodeGeneratorResponse_File$json = const {
  '1': 'File',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'insertion_point', '3': 2, '4': 1, '5': 9},
    const {'1': 'content', '3': 15, '4': 1, '5': 9},
  ],
};

