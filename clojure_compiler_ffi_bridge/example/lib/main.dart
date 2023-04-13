import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:clojure_compiler_bridge/clojure_compiler_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String callResult;
  late String evalResult;
  static const fib = '((def! fib (fn* (N) (if (= N 0) 1 (if (= N 1) 1 (+ (fib (- N 1)) (fib (- N 2))))))) 10)';
  // late Future<int> sumAsyncResult;

  @override
  void initState() {
    super.initState();
    final engine = Compiler();
    callResult = engine.evalLine(fib);
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    evalResult = encoder.convert(engine.parseLine(fib));
    // sumAsyncResult = clojure_compiler_bridge.sumAsync(3, 4);
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                Text(
                  '10! = $callResult',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tokens of $fib',
                  style: textStyle.copyWith(fontSize: 15),
                  textAlign: TextAlign.start,
                ),
                Text(
                  evalResult,
                  style: textStyle.copyWith(fontSize: 15),
                  textAlign: TextAlign.start,
                ),
                spacerSmall,
                // FutureBuilder<int>(
                //   future: sumAsyncResult,
                //   builder: (BuildContext context, AsyncSnapshot<int> value) {
                //     final displayValue =
                //         (value.hasData) ? value.data : 'loading';
                //     return Text(
                //       'await sumAsync(3, 4) = $displayValue',
                //       style: textStyle,
                //       textAlign: TextAlign.center,
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
