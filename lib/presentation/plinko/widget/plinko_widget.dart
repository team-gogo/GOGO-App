import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:gogo_app/presentation/plinko/widget/components/plinko_background.dart';
import 'package:gogo_app/presentation/plinko/widget/components/plinko_ball.dart';
import 'package:gogo_app/presentation/plinko/widget/components/plinko_obstacle.dart';

import 'components/plinko_box.dart';

class PlinkoWidget extends FlameGame with HasCollisionDetection {
  PlinkoWidget()
      : super(
            camera: CameraComponent.withFixedResolution(
                width: 340 * 2, height: 280 * 2));

  double get width => size.x;

  double get height => size.y;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(PlinkoBackground());

    final int rows = 15;
    final double spacingX = 40;
    final double spacingY = 32;
    final double startY = 0;
    // 장애물 생성 및 마지막 줄 Y 위치 추적
    double lastObstacleY = startY;
    for (int row = 2; row < rows; row++) {
      final int pinsInRow = row + 1;
      final double totalWidth = (pinsInRow - 1) * spacingX;
      final double startX = (width - totalWidth) / 2;

      for (int col = 0; col < pinsInRow; col++) {
        double x = startX + col * spacingX;
        double y = startY + row * spacingY;
        world.add(PlinkoObstacle(position: Vector2(x, y), radius: 6));

        // 마지막 장애물의 Y 위치 저장
        lastObstacleY = y;
      }
    } // 하단 점수 박스 추가 (장애물 아래 36픽셀 위치)
    final scores = [
      110,
      41,
      10,
      5,
      3,
      1.5,
      1,
      0.5,
      0.3,
      1,
      1.5,
      3,
      5,
      10,
      41,
      110
    ];

    final boxWidth = 27.0;
    final boxHeight = 20.0;
    final spacing = 8.0;
    final totalBoxesWidth =
        (boxWidth * scores.length) + (spacing * (scores.length - 1));
    final startX = (width - totalBoxesWidth) / 2 + boxWidth / 2;

    // 장애물 마지막 줄 아래 36픽셀 위치 계산
    final boxY = lastObstacleY + 36 + boxHeight / 2;

    for (int i = 0; i < scores.length; i++) {
      final x = startX + i * (boxWidth + spacing);
      world.add(
        PlinkoBox(
          position: Vector2(x, boxY),
          size: Vector2(boxWidth, boxHeight),
          value: scores[i],
        ),
      );
    }

    // 공 추가
    world.add(
      PlinkoBall(
        velocity: Vector2(0, 0),
        position: Vector2(width / 2, 10),
        radius: 5,
      ),
    );

    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void remove(Component component) {
    // TODO: implement remove
    super.remove(component);
  }
}
