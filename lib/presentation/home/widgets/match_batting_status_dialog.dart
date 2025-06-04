import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class MatchBattingStatusDialog extends StatefulWidget {
  final int teamAPoint;
  final int teamBPoint;
  final String teamA;
  final String teamB;
  final bool enableBetting;
  final DateTime startDate;
  final GameType gameType;
  final MatchRound? round;
  final System system;
  final String? selectedTeam;
  final VoidCallback closeDialog;
  final void Function() onBattingClick;
  final void Function(String) setSelectedTeam;
  final TextEditingController bettingController;

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
    required this.selectedTeam,
    required this.closeDialog,
    required this.onBattingClick,
    required this.bettingController,
    required this.setSelectedTeam,
  });

  @override
  State<MatchBattingStatusDialog> createState() =>
      _MatchBattingStatusDialogState();
}

class _MatchBattingStatusDialogState extends State<MatchBattingStatusDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.bettingController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final int maxPoints = max(widget.teamAPoint, widget.teamBPoint);
    final int totalPoints = widget.teamAPoint + widget.teamBPoint;
    final int aTeamPercentage = totalPoints == 0
        ? 0
        : ((widget.teamAPoint / totalPoints) * 100).toInt();
    final int bTeamPercentage = totalPoints == 0
        ? 0
        : ((widget.teamBPoint / totalPoints) * 100).toInt();

    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: GogoColors.gray700,
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
                        '${widget.teamA}팀 VS ${widget.teamB}팀',
                        style: GogoTypography.body1Extrabold.copyWith(
                          color: GogoColors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      GogoIcons.x(
                        width: 32,
                        height: 32,
                        onTap: widget.closeDialog,
                        color: GogoColors.white,
                      )
                    ],
                  ),
                  Row(
                    spacing: 20,
                    children: [
                      switch (widget.system) {
                        System.TOURNAMENT => GogoTagComponent.small(
                            isBorder: false,
                            color: switch (widget.round) {
                              MatchRound.ROUND_OF_32 => GogoColors.white,
                              MatchRound.ROUND_OF_16 => GogoColors.white,
                              MatchRound.QUARTER_FINALS => GogoColors.white,
                              MatchRound.SEMI_FINALS => GogoColors.white,
                              MatchRound.FINALS => GogoColors.main300,
                              null => GogoColors.white,
                            },
                            text: switch (widget.round) {
                              MatchRound.ROUND_OF_32 => "32",
                              MatchRound.ROUND_OF_16 => "16",
                              MatchRound.QUARTER_FINALS => "4",
                              MatchRound.SEMI_FINALS => "2",
                              MatchRound.FINALS => "결승전",
                              null => "",
                            },
                            icon: widget.round == MatchRound.FINALS
                                ? GogoIcons.flame(
                                    color: switch (widget.round) {
                                      MatchRound.ROUND_OF_32 =>
                                        GogoColors.white,
                                      MatchRound.ROUND_OF_16 =>
                                        GogoColors.white,
                                      MatchRound.QUARTER_FINALS =>
                                        GogoColors.white,
                                      MatchRound.SEMI_FINALS =>
                                        GogoColors.white,
                                      MatchRound.FINALS => GogoColors.main300,
                                      null => GogoColors.white,
                                    },
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
                        isBorder: false,
                        color: GogoColors.white,
                        text: formatDateTimeToHourMinute(widget.startDate),
                        icon: GogoIcons.alarm(
                          color: GogoColors.white,
                          width: 12,
                          height: 12,
                        ),
                      ),
                      GogoTagComponent.small(
                        isBorder: false,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: GogoColors.main500,
                        text: switch (widget.gameType) {
                          GameType.SOCCER => "축구",
                          GameType.BASKET_BALL => "농구",
                          GameType.BASE_BALL => "야구",
                          GameType.VOLLEY_BALL => "배구",
                          GameType.BADMINTON => "배드민턴",
                          GameType.LOL => "리그오브레전드",
                          GameType.ETC => "기타",
                        },
                        icon: switch (widget.gameType) {
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: buildBattingGraph(
                          isSelected: widget.selectedTeam == widget.teamA,
                          teamName: widget.teamA,
                          maxBattingPoint: maxPoints,
                          currentTeamBattingPoint: widget.teamAPoint,
                          currentBattingPercentage: aTeamPercentage,
                          enableBetting: widget.enableBetting,
                          onClick: (team) => widget.setSelectedTeam(team),
                        ),
                      ),
                      SizedBox(width: 80), // 가운데 공간 확보용
                      Expanded(
                        child: buildBattingGraph(
                          isSelected: widget.selectedTeam == widget.teamB,
                          teamName: widget.teamB,
                          maxBattingPoint: maxPoints,
                          currentTeamBattingPoint: widget.teamBPoint,
                          currentBattingPercentage: bTeamPercentage,
                          enableBetting: widget.enableBetting,
                          onClick: (team) => widget.setSelectedTeam(team),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GogoIcons.pointCircle(height: 20, width: 20),
                          AnimatedInt(
                            currentInt: widget.teamAPoint + widget.teamBPoint,
                            builder: (int value) => Text(
                              "$value",
                              style: GogoTypography.caption1Semibold.copyWith(
                                color: GogoColors.gray300,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "VS",
                        style: GogoTypography.body1Extrabold.copyWith(
                          color: GogoColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                spacing: 12,
                children: [
                  GogoTextField(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    backgroundColor: GogoColors.gray600,
                    controller: widget.bettingController,
                    hintText: "배팅할 금액을 입력해주세요",
                    endIcon: GogoIcons.pointCircle(
                      color: true ? GogoColors.white : GogoColors.gray400,
                    ),
                  ),
                  GogoDefaultButton(
                    color: widget.selectedTeam != null &&
                            widget.enableBetting &&
                            widget.bettingController.text.isEmpty == false
                        ? GogoColors.main600
                        : GogoColors.gray400,
                    text: "배팅",
                    onTap: () {
                      if (widget.selectedTeam != null &&
                          widget.enableBetting &&
                          widget.bettingController.text.isEmpty == false) {
                        widget.onBattingClick();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Text(
                "$teamName팀",
                style: GogoTypography.body2Extrabold.copyWith(
                  color: GogoColors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          AnimatedContainer(
            height:
                max(30, min(161, 30 + 131 * (currentBattingPercentage / 100))),
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
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 1,
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
