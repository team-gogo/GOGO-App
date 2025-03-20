import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';

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
    final int totalPoints = teamAPoint + teamBPoint;
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
              BattingGraph(
                isSelected: true,
                teamName: teamA,
                maxBattingPoint: maxPoints,
                currentTeamBattingPoint: teamAPoint,
                currentBattingPercentage: aTeamPercentage,
                enableBetting: enableBetting,
                onBattingClick: (team) => onBattingClick(team),
              ),
              SizedBox(
                height: 238,
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
              BattingGraph(
                isSelected: false,
                teamName: teamB,
                maxBattingPoint: maxPoints,
                currentTeamBattingPoint: teamBPoint,
                currentBattingPercentage: bTeamPercentage,
                enableBetting: enableBetting,
                onBattingClick: (team) => onBattingClick(team),
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
                color: enableBetting ? GogoColors.main600 : GogoColors.gray400,
                text: "배팅",
                onTap: () {
                  onBattingClick("selectedTeam");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BattingGraph extends StatefulWidget {
  final bool isSelected;
  final String teamName;
  final int maxBattingPoint;
  final int currentTeamBattingPoint;
  final int currentBattingPercentage;
  final bool enableBetting;
  final Function(String) onBattingClick;

  const BattingGraph({
    super.key,
    required this.isSelected,
    required this.teamName,
    required this.maxBattingPoint,
    required this.currentTeamBattingPoint,
    required this.currentBattingPercentage,
    required this.enableBetting,
    required this.onBattingClick,
  });

  @override
  _BattingGraphState createState() => _BattingGraphState();
}

class _BattingGraphState extends State<BattingGraph> {
  int previousPercentage = 0;
  int previousPoints = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.enableBetting) {
          widget.onBattingClick(widget.teamName);
        }
      },
      child: Column(
        spacing: 24,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: [
              TweenAnimationBuilder<int>(
                tween: IntTween(
                  begin: previousPoints,
                  end: widget.currentTeamBattingPoint,
                ),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return Text(
                    '${value}P',
                    style: GogoTypography.caption1Semibold.copyWith(
                      color: GogoColors.gray300,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
                onEnd: () {
                  setState(() {
                    previousPoints = widget.currentTeamBattingPoint;
                  });
                },
              ),
              Text(
                "${widget.teamName}팀",
                style: GogoTypography.body2Extrabold.copyWith(
                  color: GogoColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          AnimatedContainer(
            height: 30 + 131 * (widget.currentBattingPercentage / 100),
            decoration: ShapeDecoration(
              color:
                  widget.isSelected ? GogoColors.main600 : GogoColors.gray500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            duration: Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                child: TweenAnimationBuilder<int>(
                  tween: IntTween(
                    begin: previousPercentage,
                    end: widget.currentBattingPercentage,
                  ),
                  duration: Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Text(
                      '$value%',
                      style: GogoTypography.body3Extrabold.copyWith(
                        color: GogoColors.white,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                  onEnd: () {
                    setState(() {
                      previousPercentage = widget.currentBattingPercentage;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
