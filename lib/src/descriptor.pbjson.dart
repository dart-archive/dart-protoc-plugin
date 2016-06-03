///
//  Generated code. Do not modify.
///
library proto2_descriptor_pbjson;

const FileDescriptorSet$json = const {
  '1': 'FileDescriptorSet',
  '2': const [
    const {'1': 'file', '3': 1, '4': 3, '5': 11, '6': '.proto2.FileDescriptorProto'},
  ],
};

const FileDescriptorProto$json = const {
  '1': 'FileDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'package', '3': 2, '4': 1, '5': 9},
    const {'1': 'dependency', '3': 3, '4': 3, '5': 9},
    const {'1': 'public_dependency', '3': 10, '4': 3, '5': 5},
    const {'1': 'weak_dependency', '3': 11, '4': 3, '5': 5},
    const {'1': 'message_type', '3': 4, '4': 3, '5': 11, '6': '.proto2.DescriptorProto'},
    const {'1': 'enum_type', '3': 5, '4': 3, '5': 11, '6': '.proto2.EnumDescriptorProto'},
    const {'1': 'service', '3': 6, '4': 3, '5': 11, '6': '.proto2.ServiceDescriptorProto'},
    const {'1': 'extension', '3': 7, '4': 3, '5': 11, '6': '.proto2.FieldDescriptorProto'},
    const {'1': 'options', '3': 8, '4': 1, '5': 11, '6': '.proto2.FileOptions'},
    const {'1': 'source_code_info', '3': 9, '4': 1, '5': 11, '6': '.proto2.SourceCodeInfo'},
  ],
};

const DescriptorProto$json = const {
  '1': 'DescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'field', '3': 2, '4': 3, '5': 11, '6': '.proto2.FieldDescriptorProto'},
    const {'1': 'extension', '3': 6, '4': 3, '5': 11, '6': '.proto2.FieldDescriptorProto'},
    const {'1': 'nested_type', '3': 3, '4': 3, '5': 11, '6': '.proto2.DescriptorProto'},
    const {'1': 'enum_type', '3': 4, '4': 3, '5': 11, '6': '.proto2.EnumDescriptorProto'},
    const {'1': 'extension_range', '3': 5, '4': 3, '5': 11, '6': '.proto2.DescriptorProto.ExtensionRange'},
    const {'1': 'options', '3': 7, '4': 1, '5': 11, '6': '.proto2.MessageOptions'},
  ],
  '3': const [DescriptorProto_ExtensionRange$json],
};

const DescriptorProto_ExtensionRange$json = const {
  '1': 'ExtensionRange',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 5},
    const {'1': 'end', '3': 2, '4': 1, '5': 5},
  ],
};

const FieldDescriptorProto$json = const {
  '1': 'FieldDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'number', '3': 3, '4': 1, '5': 5},
    const {'1': 'label', '3': 4, '4': 1, '5': 14, '6': '.proto2.FieldDescriptorProto.Label'},
    const {'1': 'type', '3': 5, '4': 1, '5': 14, '6': '.proto2.FieldDescriptorProto.Type'},
    const {'1': 'type_name', '3': 6, '4': 1, '5': 9},
    const {'1': 'extendee', '3': 2, '4': 1, '5': 9},
    const {'1': 'default_value', '3': 7, '4': 1, '5': 9},
    const {'1': 'options', '3': 8, '4': 1, '5': 11, '6': '.proto2.FieldOptions'},
  ],
  '4': const [FieldDescriptorProto_Type$json, FieldDescriptorProto_Label$json],
};

const FieldDescriptorProto_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'TYPE_DOUBLE', '2': 1},
    const {'1': 'TYPE_FLOAT', '2': 2},
    const {'1': 'TYPE_INT64', '2': 3},
    const {'1': 'TYPE_UINT64', '2': 4},
    const {'1': 'TYPE_INT32', '2': 5},
    const {'1': 'TYPE_FIXED64', '2': 6},
    const {'1': 'TYPE_FIXED32', '2': 7},
    const {'1': 'TYPE_BOOL', '2': 8},
    const {'1': 'TYPE_STRING', '2': 9},
    const {'1': 'TYPE_GROUP', '2': 10},
    const {'1': 'TYPE_MESSAGE', '2': 11},
    const {'1': 'TYPE_BYTES', '2': 12},
    const {'1': 'TYPE_UINT32', '2': 13},
    const {'1': 'TYPE_ENUM', '2': 14},
    const {'1': 'TYPE_SFIXED32', '2': 15},
    const {'1': 'TYPE_SFIXED64', '2': 16},
    const {'1': 'TYPE_SINT32', '2': 17},
    const {'1': 'TYPE_SINT64', '2': 18},
  ],
};

const FieldDescriptorProto_Label$json = const {
  '1': 'Label',
  '2': const [
    const {'1': 'LABEL_OPTIONAL', '2': 1},
    const {'1': 'LABEL_REQUIRED', '2': 2},
    const {'1': 'LABEL_REPEATED', '2': 3},
  ],
};

const EnumDescriptorProto$json = const {
  '1': 'EnumDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 3, '5': 11, '6': '.proto2.EnumValueDescriptorProto'},
    const {'1': 'options', '3': 3, '4': 1, '5': 11, '6': '.proto2.EnumOptions'},
  ],
};

const EnumValueDescriptorProto$json = const {
  '1': 'EnumValueDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'number', '3': 2, '4': 1, '5': 5},
    const {'1': 'options', '3': 3, '4': 1, '5': 11, '6': '.proto2.EnumValueOptions'},
  ],
};

const ServiceDescriptorProto$json = const {
  '1': 'ServiceDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'method', '3': 2, '4': 3, '5': 11, '6': '.proto2.MethodDescriptorProto'},
    const {'1': 'stream', '3': 4, '4': 3, '5': 11, '6': '.proto2.StreamDescriptorProto'},
    const {'1': 'options', '3': 3, '4': 1, '5': 11, '6': '.proto2.ServiceOptions'},
  ],
};

const MethodDescriptorProto$json = const {
  '1': 'MethodDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'input_type', '3': 2, '4': 1, '5': 9},
    const {'1': 'output_type', '3': 3, '4': 1, '5': 9},
    const {'1': 'options', '3': 4, '4': 1, '5': 11, '6': '.proto2.MethodOptions'},
  ],
};

const StreamDescriptorProto$json = const {
  '1': 'StreamDescriptorProto',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'client_message_type', '3': 2, '4': 1, '5': 9},
    const {'1': 'server_message_type', '3': 3, '4': 1, '5': 9},
    const {'1': 'options', '3': 4, '4': 1, '5': 11, '6': '.proto2.StreamOptions'},
  ],
};

const FileOptions$json = const {
  '1': 'FileOptions',
  '2': const [
    const {'1': 'java_package', '3': 1, '4': 1, '5': 9},
    const {'1': 'java_outer_classname', '3': 8, '4': 1, '5': 9},
    const {'1': 'java_multiple_files', '3': 10, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'java_generate_equals_and_hash', '3': 20, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'optimize_for', '3': 9, '4': 1, '5': 14, '6': '.proto2.FileOptions.OptimizeMode', '7': 'SPEED'},
    const {'1': 'cc_generic_services', '3': 16, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'java_generic_services', '3': 17, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'py_generic_services', '3': 18, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption'},
  ],
  '4': const [FileOptions_OptimizeMode$json],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const FileOptions_OptimizeMode$json = const {
  '1': 'OptimizeMode',
  '2': const [
    const {'1': 'SPEED', '2': 1},
    const {'1': 'CODE_SIZE', '2': 2},
    const {'1': 'LITE_RUNTIME', '2': 3},
  ],
};

const MessageOptions$json = const {
  '1': 'MessageOptions',
  '2': const [
    const {'1': 'message_set_wire_format', '3': 1, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'no_standard_descriptor_accessor', '3': 2, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const FieldOptions$json = const {
  '1': 'FieldOptions',
  '2': const [
    const {'1': 'ctype', '3': 1, '4': 1, '5': 14, '6': '.proto2.FieldOptions.CType', '7': 'STRING'},
    const {'1': 'packed', '3': 2, '4': 1, '5': 8},
    const {'1': 'lazy', '3': 5, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'deprecated', '3': 3, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'experimental_map_key', '3': 9, '4': 1, '5': 9},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption'},
  ],
  '4': const [FieldOptions_CType$json],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const FieldOptions_CType$json = const {
  '1': 'CType',
  '2': const [
    const {'1': 'STRING', '2': 0},
  ],
};

const EnumOptions$json = const {
  '1': 'EnumOptions',
  '2': const [
    const {'1': 'allow_alias', '3': 2, '4': 1, '5': 8, '7': 'true'},
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const EnumValueOptions$json = const {
  '1': 'EnumValueOptions',
  '2': const [
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const ServiceOptions$json = const {
  '1': 'ServiceOptions',
  '2': const [
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const MethodOptions$json = const {
  '1': 'MethodOptions',
  '2': const [
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const StreamOptions$json = const {
  '1': 'StreamOptions',
  '2': const [
    const {'1': 'uninterpreted_option', '3': 999, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption'},
  ],
  '5': const [
    const {'1': 1000, '2': 536870912},
  ],
};

const UninterpretedOption$json = const {
  '1': 'UninterpretedOption',
  '2': const [
    const {'1': 'name', '3': 2, '4': 3, '5': 11, '6': '.proto2.UninterpretedOption.NamePart'},
    const {'1': 'identifier_value', '3': 3, '4': 1, '5': 9},
    const {'1': 'positive_int_value', '3': 4, '4': 1, '5': 4},
    const {'1': 'negative_int_value', '3': 5, '4': 1, '5': 3},
    const {'1': 'double_value', '3': 6, '4': 1, '5': 1},
    const {'1': 'string_value', '3': 7, '4': 1, '5': 12},
    const {'1': 'aggregate_value', '3': 8, '4': 1, '5': 9},
  ],
  '3': const [UninterpretedOption_NamePart$json],
};

const UninterpretedOption_NamePart$json = const {
  '1': 'NamePart',
  '2': const [
    const {'1': 'name_part', '3': 1, '4': 2, '5': 9},
    const {'1': 'is_extension', '3': 2, '4': 2, '5': 8},
  ],
};

const SourceCodeInfo$json = const {
  '1': 'SourceCodeInfo',
  '2': const [
    const {'1': 'location', '3': 1, '4': 3, '5': 11, '6': '.proto2.SourceCodeInfo.Location'},
  ],
  '3': const [SourceCodeInfo_Location$json],
};

const SourceCodeInfo_Location$json = const {
  '1': 'Location',
  '2': const [
    const {
      '1': 'path',
      '3': 1,
      '4': 3,
      '5': 5,
      '8': const {'2': true},
    },
    const {
      '1': 'span',
      '3': 2,
      '4': 3,
      '5': 5,
      '8': const {'2': true},
    },
  ],
};

