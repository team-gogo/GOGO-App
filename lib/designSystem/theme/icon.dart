import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GogoIcons {
  static Widget _buildIcon(
    String fileName, {
    Color? color,
    required double width,
    required double height,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/drawable/$fileName',
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: width,
        height: height,
      ),
    );
  }

  static Widget x({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('x.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget volleyball({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('volleyball.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget trophy({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('trophy.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget trash({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('trash.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget ticket({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('ticket.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget tennis({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('tennis.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget stage({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('stage.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget stackedCoins({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('stacked_coins.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget speechBubble({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('speech_bubble.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget speakerPhone({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('speakerphonesvg.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget shellGame({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('shell_game.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget search({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('search.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget questionMarkCircle({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('question_mark_circle.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget plusCircle({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('plus_circle.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget plinko({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('plinko.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget pin({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('pin.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget person({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('person.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget pencil({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('pencil.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget onlineGame({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('online_game.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget message({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('message.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget medal({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('medal.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget image({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('image.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget hourglass({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('hourglass.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget home({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('home.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget heartOutlined({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('heart_outlined.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget heartFilled({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('heart_filled.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget handMove({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('hand_move.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget gearWheel({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('gear_wheel.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget football({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('football.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget flame({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('flame.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget filter({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('filter.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget eyeOpen({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('eye_open.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget eyeClose({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('eye_close.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget exclamationMarkCircle({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('exclamation_mark_circle.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget drawer({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('drawer.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget dollorCircle({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('dollor_circle.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget coin({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('coin.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget clock({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('clock.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget chevronUp({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('chevron_up.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget chevronRight({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('chevron_right.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget chevronLeft({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('chevron_left.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget chevronDown({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('chevron_down.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget checkboxOutlined({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('checkbox_outlined.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget checkboxFilled({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('checkbox_filled.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget check({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('check.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget bulb({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('bulb.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget bell({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('bell.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget basketball({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('basketball.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget baseball({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('baseball.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget arcade({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('arcade.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget alarm({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('alarm.svg',
          color: color, width: width, height: height, onTap: onTap);

  static Widget logo({
    Color? color,
    double width = 24,
    double height = 24,
    VoidCallback? onTap,
  }) =>
      _buildIcon('logo.svg',
          color: color, width: width, height: height, onTap: onTap);
}
