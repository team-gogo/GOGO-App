import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import '../../../../design_system/component/tag/tag_component.dart';
import 'bloc/match_card_bloc.dart';
import 'bloc/match_card_event.dart';
import 'bloc/match_card_state.dart';

class MatchCardComponent extends StatelessWidget {
  final Widget time;
  final Widget round;
  final Widget event;
  final String point;
  final String? teamA;
  final String? teamB;
  final bool enableBell;
  final bool enableBetting;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double width;

  const MatchCardComponent({
    super.key,
    required this.time,
    required this.round,
    required this.event,
    required this.point,
    required this.teamA,
    required this.teamB,
    this.enableBell = false,
    this.enableBetting = true,
    this.backgroundColor = GogoColors.gray700,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
    this.width = 343,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MatchCardAlertBloc(
            enableBell
                ? EnableMatchCardAlertState()
                : DisableMatchCardAlertState(),
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => MatchCardBettingBloc(
            enableBetting
                ? EnableMatchCardBettingState()
                : DisableMatchCardBettingState(),
          ),
        ),
      ],
      child: Container(
        padding: padding,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Column(
          spacing: 28,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    BlocBuilder<MatchCardAlertBloc, MatchCardAlertState>(
                        builder: (context, state) {
                      return GestureDetector(
                        onTap: () => context
                            .read<MatchCardAlertBloc>()
                            .add(ClickMatchCardAlertEvent()),
                        child: state is EnableMatchCardAlertState
                            ? GogoIcons.enabledBell()
                            : GogoIcons.bell(color: GogoColors.gray500),
                      );
                    }),
                    time,
                    round,
                    event
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: GogoIcons.chevronRight(
                    color: GogoColors.gray500,
                  ),
                )
              ],
            ),
            Column(
              spacing: 12,
              children: [
                Text(
                  '총 포인트 : $point',
                  style: GogoTypography.caption1Semibold.copyWith(
                    color: GogoColors.gray300,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Text(
                      "$teamA팀",
                      style: GogoTypography.body1Extrabold
                          .copyWith(color: GogoColors.white),
                    ),
                    Text(
                      "VS",
                      style: GogoTypography.body2Extrabold
                          .copyWith(color: GogoColors.gray500),
                    ),
                    Text(
                      "$teamB팀",
                      style: GogoTypography.body1Extrabold
                          .copyWith(color: GogoColors.white),
                    ),
                  ],
                ),
              ],
            ),
            BlocBuilder<MatchCardBettingBloc, MatchCardBettingState>(
                builder: (context, state) {
              return GogoDefaultButton(
                onTap: () => context
                    .read<MatchCardBettingBloc>()
                    .add(ClickMatchCardBettingEvent()),
                text: "배팅",
                textStyle: GogoTypography.caption1Semibold,
                color: state is EnableMatchCardBettingState
                    ? GogoColors.main600
                    : GogoColors.gray400,
              );
            })
          ],
        ),
      ),
    );
  }
}

class EndedMatchCardComponent extends StatelessWidget {
  final Widget round;
  final Widget event;
  final String point;
  final String winner;
  final int earnedPoint;
  final bool isPredictionSuccess;
  final bool enableBell;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double width;

  const EndedMatchCardComponent({
    super.key,
    required this.round,
    required this.event,
    required this.point,
    required this.winner,
    required this.earnedPoint,
    required this.isPredictionSuccess,
    this.enableBell = false,
    this.backgroundColor = GogoColors.gray700,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
    this.width = 343,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MatchCardAlertBloc(
        enableBell ? EnableMatchCardAlertState() : DisableMatchCardAlertState(),
      ),
      child: Container(
        padding: padding,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Column(
          spacing: 28,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    BlocBuilder<MatchCardAlertBloc, MatchCardAlertState>(
                        builder: (context, state) {
                      return GestureDetector(
                        onTap: () => context
                            .read<MatchCardAlertBloc>()
                            .add(ClickMatchCardAlertEvent()),
                        child: state is EnableMatchCardAlertState
                            ? GogoIcons.enabledBell()
                            : GogoIcons.bell(color: GogoColors.gray500),
                      );
                    }),
                    TagComponent.small(
                      color: GogoColors.gray500,
                      text: "경기 종료",
                      icon: GogoIcons.alarm(
                        color: GogoColors.gray500,
                        width: 12,
                        height: 12,
                      ),
                    ),
                    round,
                    event
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: GogoIcons.chevronRight(
                    color: GogoColors.gray500,
                  ),
                )
              ],
            ),
            Column(
              spacing: 12,
              children: [
                Text(
                  '총 포인트 : $point',
                  style: GogoTypography.caption1Semibold.copyWith(
                    color: GogoColors.gray300,
                  ),
                ),
                Text(
                  "$winner팀 승리",
                  style: GogoTypography.body1Extrabold
                      .copyWith(color: GogoColors.white),
                ),
              ],
            ),
            Column(
              spacing: 14,
              children: [
                Divider(
                  height: 0,
                  thickness: 0,
                  color: GogoColors.gray600,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isPredictionSuccess ? "예측 성공" : "예측 실패",
                      style: GogoTypography.body3Semibold.copyWith(
                        color: isPredictionSuccess
                            ? GogoColors.main500
                            : GogoColors.error,
                      ),
                    ),
                    Text(
                      "${earnedPoint.toString()}P",
                      style: GogoTypography.body3Semibold.copyWith(
                        color: isPredictionSuccess
                            ? GogoColors.main500
                            : GogoColors.error,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
