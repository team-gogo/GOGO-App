import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import '../../../../design_system/theme/color.dart';
import '../plinko_widget.dart';

class PlinkoBackground extends RectangleComponent
    with HasGameReference<PlinkoWidget> {
  PlinkoBackground() : super(paint: Paint()..color = GogoColors.gray700);

  @override
  FutureOr<void> onLoad() {
    size = Vector2(game.width, game.height);
    return super.onLoad();
  }
}
