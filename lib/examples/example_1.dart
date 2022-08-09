import 'package:flutter/material.dart';

enum Example1Stage {
  stage_1,
  stage_2,
  stage_3,
  stage_4,
  compare,
}

class AnimationExample1 extends StatelessWidget {
  final Example1Stage stage;

  const AnimationExample1({Key? key, required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (stage) {
      case Example1Stage.stage_1:
        return _Stage1();
      case Example1Stage.stage_2:
        return _Stage2();
      case Example1Stage.stage_3:
        return _Stage3();
      case Example1Stage.stage_4:
        return _Stage4();
      case Example1Stage.compare:
        return _Compare();
    }
  }
}

class _Stage1 extends StatefulWidget {
  @override
  State<_Stage1> createState() => _Stage1State();
}

class _Stage1State extends State<_Stage1> {
  late Alignment alignment;

  @override
  void initState() {
    super.initState();

    alignment = Alignment.topCenter;
  }

  // Метод, который двигает наш квадрат.
  void _moveSquare() {
    setState(() {
      /// Ось `x` остаётся неизменной. Ось `y` инвертируется с каждым нажатием
      /// кнопки. У [Alignment] `-1` - самый верх, `1` - самый нижний.
      alignment = Alignment(alignment.x, alignment.y * -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: _moveSquare,
          child: const Text('Двигать'),
        ),
        Expanded(
          child: Align(
            alignment: alignment,
            child: Container(
              width: 64,
              height: 64,
              color: Colors.cyan,
            ),
          ),
        ),
      ],
    );
  }
}

class _Stage2 extends StatefulWidget {
  @override
  State<_Stage2> createState() => _Stage2State();
}

class _Stage2State extends State<_Stage2> {
  late Alignment alignment;

  @override
  void initState() {
    super.initState();

    alignment = Alignment.topCenter;
  }

  /// Делаем нашу функцию асинхронной, т.к. нам нужны задержки между
  /// каждым передвижанием квадрата.
  void _moveSquare() async {
    /// Количество раз, которое квадрат будет двигаться.
    var step = 3;

    /// Время прохождения квадратом полного пути.
    const duration = Duration(seconds: 1);

    /// Длительность каждого передвижения.
    final stepDuration =
        Duration(milliseconds: duration.inMilliseconds ~/ step);

    /// Шаг движения квадрата по оси Y.
    ///
    /// Умножаем знак оси на -1, чтобы инвертировать направление движения.
    ///
    /// На 2 умножаем, чтобы получить полный путь (от -1 до 1).
    final alignmentYStep = (alignment.y.sign * -1 * 2) / step;

    var currentY = alignment.y;
    while (step > 0) {
      currentY += alignmentYStep;
      setState(() {
        /// Ось `x` остаётся неизменной. Ось `y` инвертируется с каждым нажатием
        /// кнопки. У [Alignment] `-1` - самый верх, `1` - самый нижний.
        alignment = Alignment(alignment.x, currentY);
      });
      step--;
      await Future.delayed(stepDuration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: _moveSquare,
          child: const Text('Двигать'),
        ),
        Expanded(
          child: Align(
            alignment: alignment,
            child: Container(
              width: 64,
              height: 64,
              color: Colors.cyan,
            ),
          ),
        ),
      ],
    );
  }
}

class _Stage3 extends StatefulWidget {
  @override
  State<_Stage3> createState() => _Stage3State();
}

class _Stage3State extends State<_Stage3> {
  late Alignment alignment;

  @override
  void initState() {
    super.initState();

    alignment = Alignment.topCenter;
  }

  /// Делаем нашу функцию асинхронной, т.к. нам нужны задержки между
  /// каждым передвижанием квадрата.
  void _moveSquare() async {
    /// Количество раз, которое квадрат будет двигаться.
    const steps = 60;

    var step = steps;

    /// Время прохождения квадратом полного пути.
    const duration = Duration(seconds: 1);

    /// Длительность каждого передвижения.
    final stepDuration =
        Duration(milliseconds: duration.inMilliseconds ~/ step);

    /// Знак оси Y на момент начала движения.
    final signY = alignment.y.sign;
    while (step >= 0) {
      /// Текущий прогресс анимации.
      var progress = step / steps;

      /// Перевод линейного прогресса в параболу.
      progress = toParabola(progress);

      /// Перевод прогресса в диапазон от -1 до 1.
      ///
      /// То есть:
      /// - Если прогресс равен 1, получаем -1
      /// - Если прогресс равен 0.5, получаем 0
      /// - Если прогресс равен 0, получаем 1
      var newY = mapToAlignmentRange(signY, progress);

      setState(() {
        alignment = Alignment(alignment.x, newY);
      });

      await Future.delayed(stepDuration);

      step--;
    }
  }

  double toParabola(double t) {
    t = 1.0 - t;
    return 1.0 - t * t;
  }

  double mapToAlignmentRange(double sign, double t) {
    return -sign * (1.0 - t) + sign * t;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: _moveSquare,
          child: const Text('Двигать'),
        ),
        Expanded(
          child: Align(
            alignment: alignment,
            child: Container(
              width: 64,
              height: 64,
              color: Colors.cyan,
            ),
          ),
        ),
      ],
    );
  }
}

class _Stage4 extends StatefulWidget {
  @override
  State<_Stage4> createState() => _Stage4State();
}

class _Stage4State extends State<_Stage4> {
  late Alignment alignment;

  @override
  void initState() {
    super.initState();

    alignment = Alignment.topCenter;
  }

  /// Возвращаемся к исходной стадии.
  ///
  /// Наш код не отличается от первого примера.
  void _moveSquare() {
    setState(() {
      /// Ось `x` остаётся неизменной. Ось `y` инвертируется с каждым нажатием
      /// кнопки. У [Alignment] `-1` - самый верх, `1` - самый нижний.
      alignment = Alignment(alignment.x, alignment.y * -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: _moveSquare,
          child: const Text('Двигать'),
        ),
        Expanded(
          /// Единственное, что изменилось из примера 1 стадии - этот виджет.
          ///
          /// Вместо [Align] мы используем [AnimatedAlign].
          ///
          /// Стоит только добавить `duration`, который отвечает за длительность анимации.
          child: AnimatedAlign(
            duration: const Duration(seconds: 1),
            alignment: alignment,
            curve: Curves.decelerate,
            child: Container(
              width: 64,
              height: 64,
              color: Colors.cyan,
            ),
          ),
        ),
      ],
    );
  }
}

class _Compare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text('Вторая стадия'),
              Expanded(
                child: _Stage2(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text('Третья стадия'),
              Expanded(
                child: _Stage3(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text('Четвертая стадия'),
              Expanded(
                child: _Stage4(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
