import 'package:flutter/material.dart';

enum Example6Stage {
  stage_1,
}

class AnimationExample6 extends StatelessWidget {
  final Example6Stage stage;

  const AnimationExample6({Key? key, required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (stage) {
      case Example6Stage.stage_1:
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
    return _Screen1(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Свиньи'),
            ),
            body: _Screen2(
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _Screen1 extends StatelessWidget {
  final VoidCallback onPressed;

  const _Screen1({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CowHero(),
        const Text(
          'Экран 1',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
        MaterialButton(
          onPressed: onPressed,
          child: Text('Перейти на экран 2'),
        )
      ],
    );
  }
}

class _Screen2 extends StatelessWidget {
  final VoidCallback onPressed;

  const _Screen2({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _CowHero(),
        const Text(
          'Экран 2 🐖🐖🐖',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
        MaterialButton(
          onPressed: onPressed,
          child: Text('Перейти на экран 1'),
        )
      ],
    );
  }
}

class _CowHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: 'карова',
      child: Material(
        color: Colors.transparent,
        child: Text(
          '🐄',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
