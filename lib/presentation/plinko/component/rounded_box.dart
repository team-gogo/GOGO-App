
import 'dart:ui';

import 'package:flame/components.dart';

class RoundedBox extends PositionComponent {
  final double width;
  final double height;
  final double borderRadius;
  final Color color;
  late Paint _paint;

  RoundedBox({
    required this.color,
    required this.width,
    required this.height,
    this.borderRadius = 5.0,
  }) {
    _paint = Paint()..color = color;
  }

  @override
  void render(Canvas canvas) {
    RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(rect, _paint);
  }
}

