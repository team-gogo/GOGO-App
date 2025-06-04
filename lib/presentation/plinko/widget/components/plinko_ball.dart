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
    required super.position,
    required double radius,
  }) : super(
          radius: radius,
          anchor: Anchor.center, // 중심을 기준으로 위치 설정
          paint: Paint()..color = GogoColors.error, // 공의 색상 설정
          children: [CircleHitbox()], // 충돌 감지를 위한 히트박스 추가
        );
}
