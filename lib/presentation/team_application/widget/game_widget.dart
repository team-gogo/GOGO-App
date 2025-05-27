import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/team_create/screen/team_create_screen.dart';
import 'package:gogo_app/router.dart';

import '../../../data/models/stage/create_stage/game.dart';
import '../../../data/models/stage/enum_type/game_type.dart';
import '../../../data/models/stage/search_stage/search_game_response.dart';
import '../../../design_system/component/tag/gogo_borderless_tag_component.dart';
import '../../../design_system/theme/icon.dart';

class GameWidget extends StatelessWidget {
  final SearchGameItem game;
  final bool isManger;

  const GameWidget({super.key, required this.game, required this.isManger});

  String _getGameCategoryText(GameType type) {
    switch (type) {
      case GameType.SOCCER:
        return '축구';
      case GameType.BASKET_BALL:
        return '농구';
      case GameType.BASE_BALL:
        return '야구';
      case GameType.VOLLEY_BALL:
        return '배구';
      case GameType.BADMINTON:
        return '배드민턴';
      case GameType.LOL:
        return '리그오브레전드';
      case GameType.ETC:
        return '기타';
    }
  }

  Widget _getGameCategoryIcon(GameType type) {
    switch (type) {
      case GameType.SOCCER:
        return GogoIcons.football(width: 24, height: 24);
      case GameType.BASKET_BALL:
        return GogoIcons.basketball(width: 24, height: 24);
      case GameType.BASE_BALL:
        return GogoIcons.baseball(width: 24, height: 24);
      case GameType.VOLLEY_BALL:
        return GogoIcons.volleyball(width: 24, height: 24);
      case GameType.BADMINTON:
        return GogoIcons.badminton(width: 24, height: 24);
      case GameType.LOL:
        return GogoIcons.onlineGame(width: 24, height: 24);
      case GameType.ETC:
        return GogoIcons.etc(width: 24, height: 24);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: GogoColors.gray700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            spacing: 24,
            children: [
              GogoBorderlessTagComponent(
                spacing: 6,
                color: GogoColors.white,
                text: switch (game.system) {
                  GameSystem.TOURNAMENT => '토너먼트',
                  GameSystem.FULL_LEAGUE => '리그전',
                  GameSystem.SINGLE => '단판',
                  GameSystem.NULL => '오류',
                },
                icon: GogoIcons.trophy(),
              ),
              GogoBorderlessTagComponent(
                spacing: 6,
                color: GogoColors.main300,
                text: '${game.teamCount}',
                icon: GogoIcons.person(),
              ),
              GogoBorderlessTagComponent(
                spacing: 6,
                color: GogoColors.main500,
                textStyle: GogoTypography.body3Semibold,
                text: _getGameCategoryText(game.category),
                icon: _getGameCategoryIcon(game.category),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            game.gameName,
            style:
                GogoTypography.body1Extrabold.copyWith(color: GogoColors.white),
          ),
          SizedBox(
            height: 40,
          ),
          isManger
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    GogoDefaultButton(
                      onTap: () {},
                      text: "신청하기",
                      width: 148,
                    ),
                    GogoDefaultButton(
                      onTap: () {},
                      text: "종료하기",
                      color: GogoColors.error,
                      width: 148,
                    )
                  ],
                )
              : GogoDefaultButton(
                  onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (builder) => TeamCreateScreen(
                            gameName : game.gameName,
                            gameId: game.gameId,
                            minimumTeamSize: game.teamMinCapacity,
                            maximumTeamSize: game.teamMaxCapacity,
                            game: game.category,
                          ),
                        ),
                      ),
                  text: "신청하기")
        ],
      ),
    );
  }
}
