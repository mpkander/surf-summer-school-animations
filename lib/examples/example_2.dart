import 'package:flutter/material.dart';

enum Example2Stage {
  stage_1,
  stage_2,
}

class AnimationExample2 extends StatelessWidget {
  final Example2Stage stage;

  const AnimationExample2({Key? key, required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (stage) {
      case Example2Stage.stage_1:
        return _Stage1();
      case Example2Stage.stage_2:
        return _Stage2();
    }
  }
}

class _Stage1 extends StatefulWidget {
  @override
  State<_Stage1> createState() => _Stage1State();
}

class _Stage1State extends State<_Stage1> {
  late bool enabled;

  @override
  void initState() {
    super.initState();

    enabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _Switch1(
        value: enabled,
        onChanged: (newValue) {
          setState(() {
            enabled = newValue;
          });
        },
      ),
    );
  }
}

class _Stage2 extends StatefulWidget {
  @override
  State<_Stage2> createState() => _Stage2State();
}

class _Stage2State extends State<_Stage2> {
  late bool enabled;

  @override
  void initState() {
    super.initState();

    enabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Switch1(
            value: enabled,
            onChanged: (newValue) {
              setState(() {
                enabled = newValue;
              });
            },
          ),
          const SizedBox(height: 40),
          _Switch2(
            value: enabled,
            onChanged: (newValue) {
              setState(() {
                enabled = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _Switch1 extends StatelessWidget {
  /// Текущее значение свитчера.
  final bool value;

  /// Реакция на нажатие по свитчеру.
  ///
  /// Отправляет актуальное значение после нажатия. Не изменяет UI свитчера сам
  /// по себе, если явно не задать [value].
  ///
  /// Не реагирует, если [isActive] находится в положении `false`.
  final ValueChanged<bool> onChanged;

  const _Switch1({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final enabledColor = colorScheme.primary;
    final disabledColor = colorScheme.inversePrimary;

    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: SizedBox.fromSize(
        size: const Size(220, 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),

            /// Меняем значение цвета с анимацией.
            color: value ? enabledColor : disabledColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),

            /// Как можно заметить одна анимация вложена в другую, и это
            /// абсолютно нормально.
            child: AnimatedAlign(
              /// Меняем положение переключателя. Почти как в первом примере.
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 500),
              child: _Toggle1(value: value),
            ),
          ),
        ),
      ),
    );
  }
}

class _Toggle1 extends StatelessWidget {
  final bool value;

  const _Toggle1({required this.value});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.onPrimary,
      ),
    );
  }
}

class _Switch2 extends StatelessWidget {
  /// Текущее значение свитчера.
  final bool value;

  /// Реакция на нажатие по свитчеру.
  ///
  /// Отправляет актуальное значение после нажатия. Не изменяет UI свитчера сам
  /// по себе, если явно не задать [value].
  ///
  /// Не реагирует, если [isActive] находится в положении `false`.
  final ValueChanged<bool> onChanged;

  const _Switch2({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final enabledColor = colorScheme.primary;
    final disabledColor = colorScheme.inversePrimary;

    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: SizedBox.fromSize(
        size: const Size(220, 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),

            /// Меняем значение цвета с анимацией.
            color: value ? enabledColor : disabledColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),

            /// Как можно заметить одна анимация вложена в другую, и это
            /// абсолютно нормально.
            child: AnimatedAlign(
              /// Меняем положение переключателя. Почти как в первом примере.
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 500),
              child: _Toggle2(value: value),
            ),
          ),
        ),
      ),
    );
  }
}

class _Toggle2 extends StatelessWidget {
  final bool value;

  const _Toggle2({required this.value});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedRotation(
      duration: const Duration(milliseconds: 1000),
      turns: value ? 0 : 1.125,
      /// Здесь также одна анимация вложена в другую.
      /// 
      /// Переключатель одновременно совершает оборот, меняет бордер радиус
      /// и размер.
      child: AnimatedContainer(
        height: value ? 100 : 60,
        width: value ? 100 : 60,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: value ? BorderRadius.circular(80) : BorderRadius.zero,
        ),
      ),
    );
  }
}
