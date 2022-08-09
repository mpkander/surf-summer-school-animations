import 'package:flutter/material.dart';

enum Example3Stage {
  stage_1,
  stage_2,
  stage_3,
  stage_4,
}

class AnimationExample3 extends StatelessWidget {
  final Example3Stage stage;

  const AnimationExample3({Key? key, required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (stage) {
      case Example3Stage.stage_1:
        return _Stage1();
      case Example3Stage.stage_2:
        return _Stage2();
      case Example3Stage.stage_3:
        return _Stage3();
      case Example3Stage.stage_4:
        return _Stage4();
    }
  }
}

class _Stage1 extends StatefulWidget {
  @override
  State<_Stage1> createState() => _Stage1State();
}

class _Stage1State extends State<_Stage1> {
  Stream<Alignment> get alignmentStream async* {
    var alignment = Alignment.topCenter;

    /// Количество раз, которое квадрат будет двигаться.
    const steps = 60;

    var step = steps;

    /// Время прохождения квадратом пути в одну сторону.
    const duration = Duration(seconds: 1);

    /// Длительность каждого передвижения.
    final stepDuration =
        Duration(milliseconds: duration.inMilliseconds ~/ step);

    /// Знак оси Y на момент начала движения.
    var signY = alignment.y.sign;
    while (true) {
      /// Текущий прогресс анимации.
      var progress = step / steps;

      /// Перевод прогресса в диапазон от -1 до 1.
      ///
      /// То есть:
      /// - Если прогресс равен 1, получаем -1
      /// - Если прогресс равен 0.5, получаем 0
      /// - Если прогресс равен 0, получаем 1
      var newY = mapToAlignmentRange(signY, progress);

      alignment = Alignment(alignment.x, newY);

      yield alignment;

      await Future.delayed(stepDuration);

      step--;

      if (step == 0) {
        step = steps;
        signY = -signY;
      }
    }
  }

  double mapToAlignmentRange(double sign, double t) {
    return -sign * (1.0 - t) + sign * t;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Alignment>(
      stream: alignmentStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Align(
          alignment: snapshot.data!,
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

class _Stage2 extends StatefulWidget {
  @override
  State<_Stage2> createState() => _Stage2State();
}

class _Stage2State extends State<_Stage2> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();

    /// Зацикливаем.
    controller.repeat(reverse: true);
  }

  double mapToAlignmentRange(double t) {
    return -1 * (1.0 - t) + 1 * t;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final progress = controller.value;

        final alignment = Alignment(
          0,
          mapToAlignmentRange(progress),
        );

        return Align(
          alignment: alignment,
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

class _Stage3 extends StatefulWidget {
  @override
  State<_Stage3> createState() => _Stage3State();
}

class _Stage3State extends State<_Stage3> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();

    /// Зацикливаем.
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Align(
          alignment: Alignment.lerp(
            Alignment.topCenter,
            Alignment.bottomCenter,
            controller.value,
          )!,
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

class _Stage4 extends StatefulWidget {
  @override
  State<_Stage4> createState() => _Stage4State();
}

class _Stage4State extends State<_Stage4> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late Animation<Alignment> animation;

  @override
  void initState() {
    super.initState();

    /// Зацикливаем.
    controller.repeat(reverse: true);

    /// Та самая интерполяция.
    animation = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(controller);
  }

  double mapToAlignmentRange(double t) {
    return -1 * (1.0 - t) + 1 * t;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Align(
          alignment: animation.value,
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
