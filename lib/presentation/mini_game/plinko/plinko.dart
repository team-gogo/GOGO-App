import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:gogo_app/design_system/theme/color.dart';

double getRandomNumber(double min, double max) {
  final random = Random();
  return min + (max - min) * random.nextDouble();
}

class PlinkoGame extends Forge2DGame {
  PlinkoGame() : super(gravity: Vector2(0, 1000));

  @override
  Future<void> onLoad() async {
    addObstacles();
  }

  void addObstacles() async {
    double startX = size.x / 2;
    double startY = size.y / 5;
    double spacing = 25;

    for (int row = 0; row < 15; row++) {
      for (int col = 0; col <= row; col++) {
        if (row == 0 || row == 1) continue;
        double x = startX + col * spacing - (row * spacing / 2);
        double y = startY + row * spacing;
        add(Obstacle(Vector2(x, y)));
      }
    }
    for (int i = 0; i < 20; i++) {
      await Future.delayed(Duration(milliseconds: 1000));
      add(Ball(Vector2(startX + getRandomNumber(-10, 10), startY - 50)));
    }
  }
}

class Obstacle extends BodyComponent {
  final Vector2 position;
  final Color color; // 색상 추가
  late Paint _paint;

  Obstacle(this.position, {this.color = GogoColors.main300}) {
    _paint = Paint()..color = color;
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 4;
    final fixtureDef = FixtureDef(shape, density: 1, restitution: 0.3);
    final bodyDef = BodyDef(position: position, type: BodyType.static);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    canvas.drawCircle(center, radius, _paint);
  }
}

class Ball extends BodyComponent {
  final Vector2 position;

  Ball(this.position);

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 5;
    final fixtureDef = FixtureDef(shape, density: 1, restitution: 0.9);
    final bodyDef = BodyDef(position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
