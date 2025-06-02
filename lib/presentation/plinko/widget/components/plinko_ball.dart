import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import '../../../../design_system/theme/color.dart';
import '../plinko_widget.dart';
import 'plinko_obstacle.dart';

class PlinkoBall extends CircleComponent
    with CollisionCallbacks, HasGameReference<PlinkoWidget> {
  PlinkoBall({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
          radius: radius,
          anchor: Anchor.center, // 중심을 기준으로 위치 설정
          paint: Paint()..color = GogoColors.error, // 공의 색상 설정
          children: [CircleHitbox()], // 충돌 감지를 위한 히트박스 추가
        );

  Vector2 velocity; // 공의 현재 속도 벡터
  final Vector2 gravity = Vector2(0, 1000); // y축 방향의 중력 가속도

  @override
  void update(double dt) {
    // 중력 가속도를 속도에 적용
    velocity += gravity * dt;
    // 속도를 위치에 적용하여 공 이동
    position += velocity * dt;
    super.update(dt);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    // 장애물과 충돌 시 처리
    if (other is PlinkoObstacle) {
      final normal =
          (absoluteCenter - other.absoluteCenter).normalized(); // 장애물 → 공 방향
      final dot = velocity.dot(normal);
      final reflection = velocity - normal.scaled(2 * dot);

      // 반사 후 감속 계수 적용 (에너지 소실 효과)
      velocity.setFrom(reflection * 0.8);
    }
  }
}
