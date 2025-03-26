import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/match_round.dart';
import 'package:gogo_app/data/models/stage/enum_type/system_type.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import '../../../../data/models/common/match_dto.dart';
import '../../../../data/util/data_time_formatter.dart';
import '../../../../design_system/component/tag/gogo_tag_component.dart';

class MatchCard extends StatelessWidget {
  final MatchDto matchDto;
  final double width;

  const MatchCard({
    super.key,
    required this.matchDto,
    this.width = 343,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      width: width,
      decoration: BoxDecoration(
        color: GogoColors.gray700,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                  GestureDetector(
                    onTap: () {},
                    child: matchDto.isNotice
                        ? GogoIcons.enabledBell()
                        : GogoIcons.bell(color: GogoColors.gray500),
                  ),
                  GogoTagComponent.small(
                    color: GogoColors.success,
                    text: formatDateTimeToHourMinute(matchDto.startDate),
                    icon: GogoIcons.alarm(
                      color: GogoColors.success,
                      width: 12,
                      height: 12,
                    ),
                  ),
                  switch (matchDto.system) {
                    System.TOURNAMENT => GogoTagComponent.small(
                        color: GogoColors.white,
                        text: switch (matchDto.round) {
                          MatchRound.ROUND_OF_32 => "32",
                          MatchRound.ROUND_OF_16 => "16",
                          MatchRound.QUARTER_FINALS => "4",
                          MatchRound.SEMI_FINALS => "2",
                          MatchRound.FINALS => "결승전",
                          null => "",
                        },
                        icon: matchDto.round == MatchRound.FINALS
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
                    text: switch (matchDto.category) {
                      GameType.SOCCER => "축구",
                      GameType.BASKET_BALL => "농구",
                      GameType.BASE_BALL => "야구",
                      GameType.VOLLEY_BALL => "배구",
                      GameType.BADMINTON => "배드민턴",
                      GameType.LOL => "리그오브레전드",
                      GameType.ETC => "기타",
                    },
                    icon: switch (matchDto.category) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  GogoIcons.pointCircle(height: 20, width: 20),
                  Text(
                    '${matchDto.aTeam.bettingPoint + matchDto.bTeam.bettingPoint}',
                    style: GogoTypography.caption1Semibold.copyWith(
                      color: GogoColors.gray300,
                    ),
                  ),
                ],
              ),
              matchDto.isEnd
                  ? Text(
                      "${matchDto.result?.victoryTeamId == matchDto.aTeam.teamId ? matchDto.aTeam.teamName : matchDto.bTeam.teamName}팀 승리",
                      style: GogoTypography.body1Extrabold
                          .copyWith(color: GogoColors.white),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Text(
                          "${matchDto.aTeam.teamName}팀",
                          style: GogoTypography.body1Extrabold
                              .copyWith(color: GogoColors.white),
                        ),
                        Text(
                          "VS",
                          style: GogoTypography.body2Extrabold
                              .copyWith(color: GogoColors.gray500),
                        ),
                        Text(
                          "${matchDto.bTeam.teamName}팀",
                          style: GogoTypography.body1Extrabold
                              .copyWith(color: GogoColors.white),
                        ),
                      ],
                    ),
            ],
          ),
          matchDto.isEnd
              ? Column(
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
                          matchDto.result!.isPredictionSuccess!
                              ? "예측 성공"
                              : "예측 실패",
                          style: GogoTypography.body3Semibold.copyWith(
                            color: matchDto.result!.isPredictionSuccess!
                                ? GogoColors.main500
                                : GogoColors.error,
                          ),
                        ),
                        Text(
                          "${matchDto.result!.earnedPoint.toString()}P",
                          style: GogoTypography.body3Semibold.copyWith(
                            color: matchDto.result!.isPredictionSuccess!
                                ? GogoColors.main500
                                : GogoColors.error,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : GogoDefaultButton(
                  onTap: () {},
                  text: "배팅",
                  textStyle: GogoTypography.caption1Semibold,
                  color:
                      matchDto.isEnd ? GogoColors.main600 : GogoColors.gray400,
                )
        ],
      ),
    );
  }
}