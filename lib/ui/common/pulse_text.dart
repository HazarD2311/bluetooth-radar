import 'package:flutter/material.dart';

class PulsatingTextWidget extends StatefulWidget {
  final String initialText;

  const PulsatingTextWidget(this.initialText, {super.key});

  @override
  PulsatingTextWidgetState createState() => PulsatingTextWidgetState();
}

class PulsatingTextWidgetState extends State<PulsatingTextWidget>
    with SingleTickerProviderStateMixin {
  late String _currentText;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _currentText = widget.initialText;

    // Инициализация анимации
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {}
      });

    _controller.forward();
  }

  void _updateText(String newText) {
    if (newText != _currentText) {
      setState(() {
        _currentText = newText;
        _controller.forward(from: 0.0); // Запуск анимации при изменении текста
      });
    }
  }

  @override
  void didUpdateWidget(covariant PulsatingTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialText != widget.initialText) {
      _updateText(widget.initialText);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Text(
          _currentText,
          style: TextStyle(
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
