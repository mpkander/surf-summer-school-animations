import 'package:flutter/material.dart';

enum Example5Stage {
  stage_1,
  stage_2,
  stage_3,
  stage_4,
}

class AnimationExample5 extends StatelessWidget {
  final Example5Stage stage;

  const AnimationExample5({Key? key, required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (stage) {
      case Example5Stage.stage_1:
        return _Stage1();
      case Example5Stage.stage_2:
        return _Stage2();
      case Example5Stage.stage_3:
        return _Stage3();
      case Example5Stage.stage_4:
        return _Stage4();
    }
  }
}

class _Stage1 extends StatefulWidget {
  @override
  State<_Stage1> createState() => _Stage1State();
}

class _Stage1State extends State<_Stage1> {
  late bool showFirstScreen;

  @override
  void initState() {
    super.initState();
    showFirstScreen = true;
  }

  void _changeScreen(bool value) {
    setState(() {
      showFirstScreen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: showFirstScreen
            ? _Screen1(
                onPressed: () => _changeScreen(false),
              )
            : _Screen2(
                onPressed: () => _changeScreen(true),
              ),
      ),
    );
  }
}

class _Stage2 extends StatefulWidget {
  @override
  State<_Stage2> createState() => _Stage2State();
}

class _Stage2State extends State<_Stage2> {
  late bool showFirstScreen;

  @override
  void initState() {
    super.initState();
    showFirstScreen = true;
  }

  void _changeScreen(bool value) {
    setState(() {
      showFirstScreen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: showFirstScreen
            ? _Screen1(
                onPressed: () => _changeScreen(false),
              )
            : _Screen2(
                onPressed: () => _changeScreen(true),
              ),
      ),
    );
  }
}

class _Stage3 extends StatefulWidget {
  @override
  State<_Stage3> createState() => _Stage3State();
}

class _Stage3State extends State<_Stage3> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _Screen1(
        onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
                body: _Screen2(
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return child;
              },
            )),
      ),
    );
  }
}

class _Stage4 extends StatefulWidget {
  @override
  State<_Stage4> createState() => _Stage4State();
}

class _Stage4State extends State<_Stage4> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _Screen1(
        onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
                body: _Screen2(
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.decelerate,
                    ),
                  ),
                  child: child,
                );
              },
            )),
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
        const Text(
          'Экран 1 🐄🐄🐄',
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
