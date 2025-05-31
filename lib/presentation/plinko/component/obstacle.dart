import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';

import '../../../../design_system/theme/color.dart';

class Obstacle extends BodyComponent {
  final Vector2 position;
  final Color color;
  late Paint _paint;

  Obstacle(this.position, {this.color = GogoColors.main300}) {
    _paint = Paint()..color = color;
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 3;
    final fixtureDef = FixtureDef(shape, density: 1, restitution: 0.5);
    final bodyDef = BodyDef(position: position, type: BodyType.static);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    canvas.drawCircle(center, radius, _paint);
  }
}
