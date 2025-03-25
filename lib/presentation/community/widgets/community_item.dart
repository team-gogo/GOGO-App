import 'package:flutter/material.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';

import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';

class CommunityItem extends StatelessWidget {
  CommunityItem({
    super.key,
    required this.gameType,
    required this.title,
    required this.name,
    required this.commentNum,
    required this.likeNum,
  });

  final GameType gameType;
  final String title;
  final String name;
  final int commentNum;
  final int likeNum;

  Map<GameType, Widget> gameTypeIcons = {
    GameType.SOCCER:
        GogoIcons.football(color: GogoColors.main500, height: 16, width: 16),
    GameType.BASKET_BALL:
        GogoIcons.basketball(color: GogoColors.main500, height: 16, width: 16),
    GameType.BASE_BALL:
        GogoIcons.baseball(color: GogoColors.main500, height: 16, width: 16),
    GameType.VOLLEY_BALL:
        GogoIcons.volleyball(color: GogoColors.main500, height: 16, width: 16),
    GameType.BADMINTON:
        GogoIcons.badminton(color: GogoColors.main500, height: 16, width: 16),
    GameType.LOL:
        GogoIcons.eSports(color: GogoColors.main500, height: 16, width: 16),
    GameType.ETC: GogoIcons.etc(
        color: GogoColors.main500, height: 16, width: 16), // 기본 아이콘
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: GogoColors.gray700,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: gameTypeIcons[gameType] ??
                  GogoIcons.etc(
                      color: GogoColors.main500, height: 16, width: 16)),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GogoTypography.caption3Semibold.copyWith(
                  color: GogoColors.white, overflow: TextOverflow.ellipsis),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                name,
                style: GogoTypography.caption3Semibold.copyWith(
                    color: GogoColors.gray300, overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Row(
                  children: [
                    GogoIcons.community(
                        color: GogoColors.gray300, width: 12, height: 12),
                    SizedBox(width: 4),
                    Text(
                      commentNum.toString(),
                      style: GogoTypography.caption3Semibold.copyWith(
                        color: GogoColors.gray300,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                Row(
                  children: [
                    GogoIcons.heartOutlined(
                        color: GogoColors.gray300, width: 12, height: 12),
                    SizedBox(width: 4),
                    Text(
                      likeNum.toString(),
                      style: GogoTypography.caption3Semibold.copyWith(
                        color: GogoColors.gray300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
