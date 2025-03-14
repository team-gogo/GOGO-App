import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:gogo_app/design_system/theme/color.dart';

import 'component/ball.dart';
import 'component/obstacle.dart';
import 'component/rounded_box.dart';

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
    double spacing = 22;

    for (int row = 0; row < 16 + 2; row++) {
      for (int col = 0; col <= row; col++) {
        double x = startX + col * spacing - (row * spacing / 2);
        double y = startY + row * spacing;
        if (row == 0 || row == 1) continue;
        if (row == 17 && col != 0) {
          add(
            RoundedBox(
              color: GogoColors.main100,
              width: 17,
              height: 15,
            )..position = Vector2(x - 20, y + 20),
          );
        }

        add(Obstacle(Vector2(x, y)));
      }
    }
    for (int i = 0; i < 10000; i++) {
      await Future.delayed(Duration(milliseconds: 1000));
      add(Ball(Vector2(startX + getRandomNumber(-10, 10), startY - 50)));
    }
  }
}
