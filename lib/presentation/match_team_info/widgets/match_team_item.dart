import 'package:flutter/material.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_response.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

import 'match_team_info_modal/screens/match_team_info_modal.dart';

class MatchTeamItem extends StatelessWidget {
  const MatchTeamItem({super.key, required this.team, required this.game});

  final SearchTeam team;
  final GameType game;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (builder) => MatchTeamInfoModal(
                teamId: team.teamId,
                winCount: team.winCount,
                game: game,
              )),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
            color: GogoColors.gray700, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              team.teamName,
              style: GogoTypography.caption3Semibold
                  .copyWith(color: GogoColors.white),
            ),
            Row(
              spacing: 10,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    GogoIcons.trophy(color: GogoColors.white),
                    Text(
                      '${team.winCount}승',
                      style: GogoTypography.caption3Semibold
                          .copyWith(color: GogoColors.white),
                    )
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    GogoIcons.person(color: GogoColors.main300),
                    Text(
                      '${team.participantCount}명',
                      style: GogoTypography.caption3Semibold
                          .copyWith(color: GogoColors.main300),
                    )
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Text('자세히보기',
                        style: GogoTypography.caption3Semibold
                            .copyWith(color: GogoColors.gray300)),
                    GogoIcons.chevronRight(
                        color: GogoColors.gray300, width: 20, height: 20)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
