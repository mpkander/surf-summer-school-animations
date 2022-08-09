import 'package:flutter/material.dart';
import 'package:surf_summer_animations/examples/example_1.dart';
import 'package:surf_summer_animations/examples/example_2.dart';
import 'package:surf_summer_animations/examples/example_3.dart';
import 'package:surf_summer_animations/examples/example_4.dart';
import 'package:surf_summer_animations/examples/example_5.dart';
import 'package:surf_summer_animations/examples/example_6.dart';

enum AnimationExampleType {
  example_1,
  example_2,
  example_3,
  example_4,
  example_5,
  example_6,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.cyan,
      ),
      home: const _RootPage(example: AnimationExampleType.example_6),
    );
  }
}

class _RootPage extends StatelessWidget {
  final AnimationExampleType example;

  const _RootPage({
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    final Widget child;
    switch (example) {
      case AnimationExampleType.example_1:
        child = const AnimationExample1(stage: Example1Stage.stage_3);
        break;
      case AnimationExampleType.example_2:
        child = const AnimationExample2(stage: Example2Stage.stage_1);
        break;
      case AnimationExampleType.example_3:
        child = const AnimationExample3(stage: Example3Stage.stage_3);
        break;
      case AnimationExampleType.example_4:
        child = const AnimationExample4(stage: Example4Stage.stage_1);
        break;
      case AnimationExampleType.example_5:
        child = const AnimationExample5(stage: Example5Stage.stage_4);
        break;
      case AnimationExampleType.example_6:
        child = const AnimationExample6(stage: Example6Stage.stage_1);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Анимации'),
      ),
      body: child,
    );
  }
}
