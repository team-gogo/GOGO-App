import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/painting.dart'; // TextStyle 사용을 위해 추가
import 'package:gogo_app/design_system/theme/typography.dart';

import '../../../../design_system/theme/color.dart';
import '../plinko_widget.dart';

class PlinkoBox extends PositionComponent with HasGameReference<PlinkoWidget> {
  final num value; // 표시할 텍스트

  PlinkoBox({
    required super.position,
    required super.size,
    required this.value, // 생성자에 text 추가
  }) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, width, height),
        Radius.circular(6),
      ),
      Paint()..color = GogoColors.main100,
    );

    super.render(canvas);
  }

  @override
  FutureOr<void> onLoad() async {
    final textComponent = TextComponent(
      text: value.toString(),
      textRenderer: TextPaint(
          style: GogoTypography.caption3Semibold
              .copyWith(color: GogoColors.main600)),
      anchor: Anchor.center,
      position: size / 2, // 박스 중앙에 위치
    );

    add(textComponent); // 박스에 텍스트 추가

    return super.onLoad();
  }
}
