import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class MinigameTopBar extends StatelessWidget {
  // 미니게임 공통 탑바
  final double width;
  final double height;
  final Widget icon;
  final String text;
  final Widget component;

  const MinigameTopBar({
    this.width = 343,
    required this.height,
    required this.icon,
    required this.text,
    required this.component,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 67.w,
            height: height,
            child: Row(
              spacing: 8.w,
              children: [
                icon,
                Text(
                  text,
                  style: GogoTypography.body2Extrabold.copyWith(
                    color: GogoColors.white,
                  ),
                ),
              ],
            ),
          ),
          component,
        ],
      ),
    );
  }
}

// 미니게임 탑바 티켓

class MinigameTicket extends StatelessWidget {
  final int tickets;
  final Widget gameIcon;

  const MinigameTicket({
    required this.tickets,
    required this.gameIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        gameIcon,
        Text(
          '$tickets',
          style: GogoTypography.body3Semibold,
        ),
      ],
    );
  }
}
