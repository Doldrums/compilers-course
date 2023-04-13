import 'dart:ffi';

import 'package:clojure_compiler_bridge/utils.dart';
import 'package:ffi/ffi.dart';

import 'clojure_compiler_bridge_bindings_generated.dart';

final dylib = DynamicLibrary.process();
final ClojureCompilerBridgeBindings _bindings =
    ClojureCompilerBridgeBindings(dylib);

class Compiler {
  Compiler() {
    _env = _bindings.init_enviroment();
  }

  String evalLine(String line) {
    return using((arena) {
      return _bindings.eval_line(line.toCString(arena), _env).toDartString() ??
          'Error :(';
    });
  }

  parseLine(String line) {
    final protobuf = using((arena) {
      return _bindings.parse_line(line.toCString(arena));
    });
  }

  late Pointer<Void> _env;
}

String evalLine(String line) {
  return using((arena) {
    final env = _bindings.init_enviroment();
    final res = _bindings.eval_line(line.toCString(arena), env);
    return res.toDartString() ?? 'Ничего не получилось';
  });
}
