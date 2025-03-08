import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_test/router.dart';

void main() {
  runApp(ProviderScope(child: QtimApp()));
}

class QtimApp extends StatelessWidget {
  const QtimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
