import 'package:flutter/material.dart';

enum Example4Stage {
  stage_1,
}

class AnimationExample4 extends StatelessWidget {
  final Example4Stage stage;

  const AnimationExample4({Key? key, required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (stage) {
      case Example4Stage.stage_1:
        return _Stage1();
    }
  }
}

class _Stage1 extends StatefulWidget {
  @override
  State<_Stage1> createState() => _Stage1State();
}

class _Stage1State extends State<_Stage1> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Alignment>(
      tween: AlignmentTween(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      duration: const Duration(seconds: 1),
      builder: (context, value, _) {
        return Align(
          alignment: value,
          child: Container(
            width: 64,
            height: 64,
            color: Colors.cyan,
          ),
        );
      },
    );
  }
}
