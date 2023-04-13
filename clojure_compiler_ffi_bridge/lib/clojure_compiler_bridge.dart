import 'dart:ffi';

import 'package:clojure_compiler_bridge/utils.dart';
import 'package:ffi/ffi.dart';

import 'clojure_compiler_bridge_bindings_generated.dart';

final dylib = DynamicLibrary.process();
final ClojureCompilerBridgeBindings _bindings =
    ClojureCompilerBridgeBindings(dylib);

String sum() {
  using((arena) {
    return _bindings.c_read_str('test'.toCString(arena)).toString();
    // print(res.toString());
    // return res == ffi.nullptr ? null :res.toString();
  });
  return 'ничиво не получилось';
}
