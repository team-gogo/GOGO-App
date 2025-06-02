import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../../../design_system/theme/color.dart';
import '../plinko_widget.dart';

class PlinkoObstacle extends CircleComponent
    with HasGameReference<PlinkoWidget> {
  PlinkoObstacle({
    required super.position,
    required double radius,
  }) : super(
          radius: radius,
          anchor: Anchor.center,
          paint: Paint()..color = GogoColors.main300,
          children: [CircleHitbox()],
        );
}
