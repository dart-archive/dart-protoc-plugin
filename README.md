Protoc compiler Dart plugin
===========================

This application provides a plugin for protoc compiler which
generates pure Dart library to deal with protobufs.

Please, do not forget that generated libraries depend on runtime
support library which can be found [here](https://github.com/dart-lang/dart-protobuf).

How to build and use
--------------------

*Note:* currently the workflow is POSIX-oriented.

To build standalone `protoc` plugin:
- run `pub install` to install all dependecies
- run `make build-plugin`. That will create a file `out/protoc-gen-dart` which
  is a plugin
- Now you can use it either by adding into `PATH` or passing directly with
  `protoc`'s `--plugin` option.

Please, remember that the plugin is pure Dart script and requires the presence
of `dart` executable in your `PATH`.

When both the `dart` executable and `out/protoc-gen-dart` are in the
`PATH` the protocol buffer compiler can be invoked to generate like this:

    $ protoc --dart_out=. test.proto

### Options to control the generated Dart code

The protocol buffer compiler accepts options for each plugin. For the
Dart plugin, these options are passed together with the `--dart_out`
option. The individial options are separated using comma, and the
final output directive is separated from the options using colon. Pass
options `<option 1>` and `<option 2>` like this:

    --dart_out="<option 1>,<option 2>:."

#### Option for setting the name of field accessors

The following message definition has the field name `has_field`.

    message MyMessage {
      optional string has_field = 1;
    }

This poses the problem, that the Dart class will have a getter and a
setter called `hasField`. This conflicts with the method `hasField`
which is already defined on the superclass `GeneratedMessage`.

To work around this problem the option `field_name` can be
used. Option `field_name` takes two values separated by the vertical
bar. The first value is the full name of the field and the second
value is the name of the field in the generated Dart code. Passing the
following option:

    --dart_out="field_name=MyMessage.has_field|HasFld:."

Will generate the following message field accessors:

    String get hasFld => getField(1);
    void set hasFld(String v) { setField(1, v); }
    bool hasHasFld() => hasField(1);
    void clearHasFld() => clearField(1);

#### Option for specifying a "part of" library

By default, each generated file declares its own library.  If you would prefer to have the generated files be part of an existing library, set the `part_of` option to the name of the library that it will be a part of.

It is important to note that when using this option, necessary imports will be omitted from the generated code.  These imports must be added to the file in which the library is declared.

Hacking
-------

Remember to run the tests. That is as easy as `make run-tests`.

The default way of running the Dart protoc plugin is through the
generated `out/protoc-gen-dart` script. However when run this way the
Dart code is assembled into one large Dart file using dart2dart. To
run with the actual source in the repository create an executable
script called `protoc-gen-dart` with the following content:

    #! /bin/bash
    dart bin/protoc_plugin.dart

When running protoc just ensure that this script is first when PATH is
searched. If the script is in the current directory run `protoc` like
this:

    $ PATH=.:$PATH protoc --dart_out=. test.proto

It is also possible to call the script something else than
`protoc-gen-dart` and then refer directly to it using the `--plugin`
option. If the script is called `dart-plugin` run `protoc` like this:

    $ protoc --plugin=protoc-gen-dart=./plugin --dart_out=. test.proto

Useful references
-----------------

* [Main Dart site](http://www.dartlang.org)
* [Main protobuf site](https://code.google.com/p/protobuf)
* [Protobuf runtime support project](https://github.com/dart-lang/dart-protobuf)
* [DartEditor download](http://www.dartlang.org)
* [Pub documentation](http://pub.dartlang.org/doc)
