import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class MinigameSelectComponent extends StatelessWidget {
  final double width;
  final double height;
  final Widget gameIcon;
  final String gameName;
  final int ticketsCost;
  final int ticketsCount;
  final bool info; // 티켓 정보이면 true, 미니게임이면 false,

  const MinigameSelectComponent({
    super.key,
    this.width = 343,
    this.height = 143,
    required this.gameIcon,
    required this.gameName,
    required this.ticketsCost,
    this.ticketsCount = 0,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 16.h, children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: GogoColors.gray700, borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Center(
              child: Column(
                spacing: 16,
                children: [
                  gameIcon,
                  Text(
                    gameName,
                    style: GogoTypography.body1Semibold.copyWith(
                      color: GogoColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 0,
                child: GogoIcons.questionMarkCircle(
                  onTap: () {},
                  color: GogoColors.gray500,
                )),
          ],
        ),
      ),
      Column(
        spacing: 8,
        children: [
          Container(
              width: width,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: GogoColors.main600,
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  info ? "게임하기기" : '$ticketsCost',
                  style: GogoTypography.caption1Semibold.copyWith(
                    color: GogoColors.white,
                  ),
                ),
              )),
          info
              ? Container()
              : Text(
                  '구매 가능한 티켓 : $ticketsCount',
                  style: GogoTypography.caption2Semibold.copyWith(
                    color: GogoColors.gray500,
                  ),
                ),
        ],
      ),
      SizedBox(
        height: 12,
      ),
    ]);
  }
}
