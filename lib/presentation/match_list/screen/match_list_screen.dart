import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';

import '../../../data/models/stage/enum_type/game_type.dart';
import '../../../data/models/stage/enum_type/match_round.dart';
import '../../../data/models/stage/enum_type/system_type.dart';
import '../../../data/models/stage/search_stage/search_betting_stage_response.dart';
import '../../../design_system/theme/icon.dart';
import '../../home/widgets/match_batting_status_dialog.dart';
import '../../home/widgets/match_card/match_card_component.dart';

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          children: [
            GogoTopBar(title: "매치 목록", onBackTap: ()=> context.pop()),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GogoTagComponent(
                    color: GogoColors.main500,
                    text: "필터",
                    icon: GogoIcons.filter(
                      color: GogoColors.main500,
                      width: 16,
                      height: 16,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 25),
            // Expanded(
            //   child: ListView.separated(
            //     itemCount: list.length,
            //     separatorBuilder: (context, index) =>
            //         SizedBox(height: 12), // 간격 추가
            //     itemBuilder: (context, index) {
            //       final matchDto = list[index];
            //       return MatchCard(
            //         matchDto: matchDto,
            //         width: double.infinity,
            //         onBattingClick: () {
            //           showDialogMatchBatting(context, matchDto);
            //         },
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void showDialogMatchBatting(
    BuildContext context,
    MatchDto data,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MatchBattingStatusDialog(
          startDate: data.startDate,
          system: data.system,
          gameType: data.category,
          round: data.round,
          teamAPoint: data.aTeam.bettingPoint,
          teamBPoint: data.bTeam.bettingPoint,
          teamA: data.aTeam.teamName,
          teamB: data.bTeam.teamName,
          enableBetting: !data.isEnd && data.startDate.isBefore(DateTime.now()),
          closeDialog: () {
            Navigator.pop(context);
          },
          onBattingClick: (String team) {},
        );
      },
    );
  }
}
