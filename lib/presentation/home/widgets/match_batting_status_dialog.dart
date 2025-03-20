import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';

import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';

class MatchBattingStatusDialog extends StatelessWidget {
  final List<Widget> detailWidgets;
  final int teamAPoint;
  final int teamBPoint;
  final String teamA;
  final String teamB;
  final bool enableBetting;
  final VoidCallback closeDialog;
  final void Function(String) onBattingClick;

  const MatchBattingStatusDialog({
    super.key,
    required this.detailWidgets,
    required this.teamAPoint,
    required this.teamBPoint,
    required this.teamA,
    required this.teamB,
    required this.enableBetting,
    required this.closeDialog,
    required this.onBattingClick,
  });

  @override
  Widget build(BuildContext context) {
    final int maxPoints = max(teamAPoint, teamBPoint);
    final int totalPoints = teamAPoint+teamBPoint;
    final int aTeamPercentage = ((teamAPoint / totalPoints) * 100).toInt();
    final int bTeamPercentage = ((teamBPoint / totalPoints) * 100).toInt();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: GogoColors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 32,
        children: [
          Column(
            spacing: 18,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '$teamA팀 VS $teamB팀',
                    style: GogoTypography.body1Extrabold.copyWith(
                      color: GogoColors.white,
                    ),
                  ),
                  GogoIcons.x(
                    width: 32,
                    height: 32,
                    onTap: closeDialog,
                    color: GogoColors.white,
                  )
                ],
              ),
              Row(
                spacing: 20,
                children: [...detailWidgets],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildBattingGraph(
                isSelected: true,
                teamName: teamA,
                maxBattingPoint: maxPoints,
                currentTeamBattingPoint: teamAPoint,
                currentBattingPercentage: aTeamPercentage,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      spacing: 4,
                      children: [
                        GogoIcons.pointCircle(height: 20, width: 20),
                        Text(
                          "${teamAPoint + teamBPoint}",
                          style: GogoTypography.caption1Semibold.copyWith(
                            color: GogoColors.gray300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Text(
                      "VS",
                      style: GogoTypography.body1Extrabold.copyWith(
                        color: GogoColors.gray500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              buildBattingGraph(
                isSelected: false,
                teamName: teamB,
                maxBattingPoint: maxPoints,
                currentTeamBattingPoint: teamBPoint,
                currentBattingPercentage: bTeamPercentage,
              ),
            ],
          ),
          GogoDefaultButton(
            color: enableBetting ? GogoColors.main600 : GogoColors.gray400,
            text: "배팅",
            onTap: () {
              onBattingClick("selectedTeam");
            },
          ),
        ],
      ),
    );
  }

  Widget buildBattingGraph({
    required bool isSelected,
    required String teamName,
    required int maxBattingPoint,
    required int currentTeamBattingPoint,
    required int currentBattingPercentage,
  }) {
    return Column(
      spacing: 24,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            Text(
              '${currentTeamBattingPoint}P',
              style: GogoTypography.caption1Semibold.copyWith(
                color: GogoColors.gray300,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "$teamName팀",
              style: GogoTypography.body2Extrabold.copyWith(
                color: GogoColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Container(
          height: 80 + 80 / maxBattingPoint * currentTeamBattingPoint,
          decoration: ShapeDecoration(
            color: isSelected ? GogoColors.main600 : GogoColors.gray500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Center(
              child: Text(
                '$currentBattingPercentage%',
                style: GogoTypography.body3Extrabold.copyWith(
                  color: GogoColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
