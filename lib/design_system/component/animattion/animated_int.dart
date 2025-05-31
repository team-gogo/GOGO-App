import 'package:flutter/material.dart';

class AnimatedInt extends StatefulWidget {
  final int currentInt;
  final Widget Function(int value) builder;
  final Duration? duration;

  const AnimatedInt({
    super.key,
    required this.currentInt,
    required this.builder,
    this.duration = const Duration(seconds: 1),
  });

  @override
  _AnimatedIntState createState() => _AnimatedIntState();
}

class _AnimatedIntState extends State<AnimatedInt> {
  int previousPoints = 0;

  @override
  void didUpdateWidget(covariant AnimatedInt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentInt != oldWidget.currentInt) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(
        begin: previousPoints,
        end: widget.currentInt,
      ),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return widget.builder(value);
      },
      onEnd: () {
        setState(() {
          previousPoints = widget.currentInt;
        });
      },
    );
  }
}
