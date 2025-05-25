import 'package:flutter/material.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/component/indicator/refresh_indicator.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_bracket_modal/screens/match_team_bracket_modal.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_item.dart';

import '../../../data/models/stage/search_stage/search_team_response.dart';
import '../../../design_system/component/button/gogo_icon_button.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';

class MatchTeamList extends StatelessWidget {
  const MatchTeamList(
      {super.key,
      required this.teamResponse,
      required this.isTournament,
      required this.onRefresh,
      required this.game,
      required this.gameId});

  final SearchTeamResponse teamResponse;
  final bool isTournament;
  final GameType game;
  final int gameId;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return GogoRefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: teamResponse.count + 1,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == 0 && isTournament) {
            return GogoIconButton.outlined(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => MatchTeamBracketModal(
                        gameId: gameId,
                      )),
              text: '대진표 보기',
              icon: GogoIcons.stage(color: GogoColors.main500),
              border: Border.all(color: GogoColors.main500, width: 1),
            );
          }
          return MatchTeamItem(team: teamResponse.team[index - 1], game: game);
        },
      ),
    );
  }
}
