import 'package:flutter/material.dart';

import '../../../data/models/stage/enum_type/game_type.dart';
import '../../../data/models/stage/search_stage/search_game_response.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';

class MatchGameItem extends StatelessWidget {
  const MatchGameItem({super.key, required this.gameItem, required this.onTap});

  final SearchGameItem gameItem;
  final VoidCallback onTap;

  _categoryIcons(GameType gameType) {
    switch (gameType) {
      case GameType.VOLLEY_BALL:
        return GogoIcons.volleyball;
      case GameType.BASKET_BALL:
        return GogoIcons.basketball;
      case GameType.SOCCER:
        return GogoIcons.football;
      case GameType.BASE_BALL:
        return GogoIcons.baseball;
      case GameType.LOL:
        return GogoIcons.eSports;
      case GameType.BADMINTON:
        return GogoIcons.badminton;
      default:
        return GogoIcons.etc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
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
                child: _categoryIcons(gameItem.category)(
                    color: GogoColors.main500, height: 16.0, width: 16.0)),
            Expanded(
              flex: 3,
              child: Text(
                gameItem.gameName,
                style: GogoTypography.caption2Semibold.copyWith(
                    color: GogoColors.white, overflow: TextOverflow.ellipsis),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    "바로가기",
                    style: GogoTypography.caption2Semibold.copyWith(
                      color: GogoColors.gray500,
                    ),
                  ),
                  GogoIcons.chevronRight(
                    color: GogoColors.gray500,
                    height: 16,
                    width: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
