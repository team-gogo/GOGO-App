import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';

import '../../../data/models/stage/enum_type/game_type.dart';
import '../../../data/models/stage/enum_type/match_round.dart';
import '../../../data/models/stage/enum_type/system_type.dart';
import '../../../data/util/data_time_formatter.dart';
import '../../../design_system/component/animattion/animated_int.dart';
import '../../../design_system/component/tag/gogo_tag_component.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';

class MatchBattingStatusDialog extends StatelessWidget {
  final int teamAPoint;
  final int teamBPoint;
  final String teamA;
  final String teamB;
  final bool enableBetting;
  final DateTime startDate;
  final GameType gameType;
  final MatchRound? round;
  final System system;
  final VoidCallback closeDialog;
  final void Function(String) onBattingClick;

  const MatchBattingStatusDialog({
    super.key,
    required this.teamAPoint,
    required this.teamBPoint,
    required this.teamA,
    required this.teamB,
    required this.enableBetting,
    required this.startDate,
    required this.gameType,
    required this.round,
    required this.system,
    required this.closeDialog,
    required this.onBattingClick,
  });

  @override
  Widget build(BuildContext context) {
    final int maxPoints = max(teamAPoint, teamBPoint);
    final int totalPoints = teamAPoint + teamBPoint;
    final int aTeamPercentage = ((teamAPoint / totalPoints) * 100).toInt();
    final int bTeamPercentage = ((teamBPoint / totalPoints) * 100).toInt();

    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: GogoColors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  children: [
                    GogoTagComponent.small(
                      color: GogoColors.success,
                      text: formatDateTimeToHourMinute(startDate),
                      icon: GogoIcons.alarm(
                        color: GogoColors.success,
                        width: 12,
                        height: 12,
                      ),
                    ),
                    switch (system) {
                      System.TOURNAMENT => GogoTagComponent.small(
                          color: GogoColors.white,
                          text: switch (round) {
                            MatchRound.ROUND_OF_32 => "32",
                            MatchRound.ROUND_OF_16 => "16",
                            MatchRound.QUARTER_FINALS => "4",
                            MatchRound.SEMI_FINALS => "2",
                            MatchRound.FINALS => "결승전",
                            null => "",
                          },
                          icon: round == MatchRound.FINALS
                              ? GogoIcons.flame(
                                  color: GogoColors.white,
                                  width: 12,
                                  height: 12,
                                )
                              : GogoIcons.trophy(
                                  color: GogoColors.white,
                                  width: 12,
                                  height: 12,
                                ),
                        ),
                      System.FULL_LEAGUE => GogoTagComponent.small(
                          color: GogoColors.white,
                          text: "리그전",
                          icon: GogoIcons.trophy(
                            color: GogoColors.white,
                            width: 12,
                            height: 12,
                          ),
                        ),
                      System.SINGLE => GogoTagComponent.small(
                          color: GogoColors.white,
                          text: "단판",
                          icon: GogoIcons.trophy(
                            color: GogoColors.white,
                            width: 12,
                            height: 12,
                          ),
                        ),
                    },
                    GogoTagComponent.small(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: GogoColors.main500,
                      text: switch (gameType) {
                        GameType.SOCCER => "축구",
                        GameType.BASKET_BALL => "농구",
                        GameType.BASE_BALL => "야구",
                        GameType.VOLLEY_BALL => "배구",
                        GameType.BADMINTON => "배드민턴",
                        GameType.LOL => "리그오브레전드",
                        GameType.ETC => "기타",
                      },
                      icon: switch (gameType) {
                        GameType.SOCCER => GogoIcons.football(
                            color: GogoColors.main500,
                            width: 12,
                            height: 12,
                          ),
                        GameType.BASKET_BALL => GogoIcons.basketball(
                            color: GogoColors.main500,
                            width: 12,
                            height: 12,
                          ),
                        GameType.BASE_BALL => GogoIcons.baseball(
                            color: GogoColors.main500,
                            width: 12,
                            height: 12,
                          ),
                        GameType.VOLLEY_BALL => GogoIcons.volleyball(
                            color: GogoColors.main500,
                            width: 12,
                            height: 12,
                          ),
                        GameType.BADMINTON => GogoIcons.badminton(
                            color: GogoColors.main500,
                            width: 12,
                            height: 12,
                          ),
                        GameType.LOL => GogoIcons.onlineGame(
                            color: GogoColors.main500,
                            width: 12,
                            height: 12,
                          ),
                        GameType.ETC => GogoIcons.volleyball(
                            color: GogoColors.main500,
                            width: 12,
                            height: 12,
                          ),
                      },
                    ),
                  ],
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
                  enableBetting: enableBetting,
                  onClick: (team) => onBattingClick(team),
                ),
                SizedBox(
                  height: 238,
                  child: Column(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 62,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4,
                          children: [
                            GogoIcons.pointCircle(height: 20, width: 20),
                            AnimatedInt(
                              currentInt: teamAPoint + teamBPoint,
                              builder: (int value) => Text(
                                "$value",
                                style: GogoTypography.caption1Semibold.copyWith(
                                  color: GogoColors.gray300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
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
                  enableBetting: enableBetting,
                  onClick: (team) => onBattingClick(team),
                ),
              ],
            ),
            Column(
              spacing: 12,
              children: [
                GogoTextField(
                  controller: TextEditingController(),
                  hintText: "배팅할 금액을 입력해주세요",
                  endIcon: GogoIcons.pointCircle(
                    color: true ? GogoColors.white : GogoColors.gray400,
                  ),
                ),
                GogoDefaultButton(
                  color:
                      enableBetting ? GogoColors.main600 : GogoColors.gray400,
                  text: "배팅",
                  onTap: () {
                    onBattingClick("selectedTeam");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBattingGraph({
    required bool isSelected,
    required String teamName,
    required int maxBattingPoint,
    required int currentTeamBattingPoint,
    required int currentBattingPercentage,
    required bool enableBetting,
    required Function(String) onClick,
  }) {
    return GestureDetector(
      onTap: () {
        if (enableBetting) {
          onClick(teamName);
        }
      },
      child: Column(
        spacing: 24,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              AnimatedInt(
                currentInt: currentTeamBattingPoint,
                builder: (int value) => Text(
                  '${value}P',
                  style: GogoTypography.caption1Semibold.copyWith(
                    color: GogoColors.gray300,
                  ),
                  textAlign: TextAlign.center,
                ),
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
          AnimatedContainer(
            height: 30 + 131 * (currentBattingPercentage / 100),
            decoration: ShapeDecoration(
              color: isSelected ? GogoColors.main600 : GogoColors.gray500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            duration: Duration(milliseconds: 500),
            child: SizedBox(
              width: 80,
              child: Center(
                child: AnimatedInt(
                  currentInt: currentBattingPercentage,
                  builder: (int value) => Text(
                    '$value%',
                    style: GogoTypography.body3Extrabold.copyWith(
                      color: GogoColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
