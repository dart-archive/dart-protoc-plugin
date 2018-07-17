PLUGIN_SRC = \
	prepend.dart \
	bin/protoc_plugin.dart \
	lib/*.dart \
	lib/src/descriptor.pb.dart \
	lib/src/plugin.pb.dart

OUTPUT_DIR=out
PLUGIN_NAME=protoc-gen-dart
PLUGIN_PATH=bin/$(PLUGIN_NAME)

BENCHMARK_PROTOS = $(wildcard benchmark/protos/*.proto)

TEST_PROTO_LIST = \
	google/protobuf/any \
	google/protobuf/unittest_import \
	google/protobuf/unittest_optimize_for \
	google/protobuf/unittest \
	dart_name \
	enum_extension \
	ExtensionEnumNameConflict \
	ExtensionNameConflict \
	foo \
	import_clash \
	map_api \
	map_api2 \
	mixins \
	multiple_files_test \
	nested_extension \
	non_nested_extension \
	reserved_names \
	duplicate_names_import \
	package1 \
	package2 \
	package3 \
	service \
	service2 \
	service3 \
	toplevel_import \
	toplevel \
	using_any
TEST_PROTO_DIR=$(OUTPUT_DIR)/protos
TEST_PROTO_LIBS=$(foreach f, $(TEST_PROTO_LIST), \
  $(TEST_PROTO_DIR)/$(f).pb.dart \
	$(TEST_PROTO_DIR)/$(f).pbenum.dart \
	$(TEST_PROTO_DIR)/$(f).pbserver.dart \
	$(TEST_PROTO_DIR)/$(f).pbjson.dart)
TEST_PROTO_SRC_DIR=test/protos
TEST_PROTO_SRCS=$(foreach proto, $(TEST_PROTO_LIST), \
  $(TEST_PROTO_SRC_DIR)/$(proto).proto)

PREGENERATED_SRCS=protos/descriptor.proto protos/plugin.proto protos/dart_options.proto

$(TEST_PROTO_LIBS): $(PLUGIN_PATH) $(TEST_PROTO_SRCS)
	[ -d $(TEST_PROTO_DIR) ] || mkdir -p $(TEST_PROTO_DIR)
	protoc\
		--dart_out=$(TEST_PROTO_DIR)\
		-Iprotos\
		-I$(TEST_PROTO_SRC_DIR)\
		--plugin=protoc-gen-dart=$(realpath $(PLUGIN_PATH))\
		$(TEST_PROTO_SRCS)

.PHONY: build-plugin build-benchmark-protos build-benchmarks \
	update-pregenerated protos run-tests clean

build-plugin: $(PLUGIN_PATH)

update-pregenerated: $(PLUGIN_PATH) $(PREGENERATED_SRCS)
	protoc --dart_out=lib/src -Iprotos --plugin=protoc-gen-dart=$(realpath $(PLUGIN_PATH)) $(PREGENERATED_SRCS)
	rm lib/src/descriptor.pb{json,server}.dart
	rm lib/src/dart_options.pb{enum,json,server}.dart
	rm lib/src/plugin.pb{enum,json,server}.dart
	dartfmt -w lib/src

protos: $(PLUGIN_PATH) $(TEST_PROTO_LIBS)
	mkdir -p benchmark/lib/generated
	protoc \
		--dart_out=benchmark/lib/generated \
		-Ibenchmark/protos \
		--plugin=protoc-gen-dart=$(realpath $(PLUGIN_PATH)) \
		$(BENCHMARK_PROTOS)

run-tests: protos
	pub run test

clean:
	rm -rf benchmark/lib/generated
	rm -rf $(OUTPUT_DIR)
