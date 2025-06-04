import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/match_round.dart';
import 'package:gogo_app/data/models/stage/enum_type/system_type.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import '../../../../data/models/common/match_dto.dart';
import '../../../../data/util/data_time_formatter.dart';
import '../../../../design_system/component/tag/gogo_borderless_tag_component.dart';
import '../../../../router.dart';

class MatchCard extends StatelessWidget {
  final MatchDto matchDto;
  final double width;
  final VoidCallback onBattingClick;

  const MatchCard({
    super.key,
    required this.matchDto,
    this.width = 343,
    required this.onBattingClick,
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
                spacing: 16,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: matchDto.isNotice
                        ? GogoIcons.enabledBell()
                        : GogoIcons.bell(color: GogoColors.gray500),
                  ),
                  switch (matchDto.system) {
                    System.TOURNAMENT => GogoBorderlessTagComponent(
                        color: matchDto.round == MatchRound.FINALS
                            ? GogoColors.main300
                            : GogoColors.white,
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
                                width: 16,
                                height: 16,
                              )
                            : GogoIcons.trophy(
                                color: GogoColors.white,
                                width: 16,
                                height: 16,
                              ),
                      ),
                    System.FULL_LEAGUE => GogoBorderlessTagComponent(
                        color: GogoColors.white,
                        text: "리그전",
                        icon: GogoIcons.trophy(
                          color: GogoColors.white,
                          width: 12,
                          height: 12,
                        ),
                      ),
                    System.SINGLE => GogoBorderlessTagComponent(
                        color: GogoColors.white,
                        text: "단판",
                        icon: GogoIcons.trophy(
                          color: GogoColors.white,
                          width: 12,
                          height: 12,
                        ),
                      ),
                  },
                  GogoBorderlessTagComponent(
                    color:
                        matchDto.isEnd ? GogoColors.gray500 : GogoColors.white,
                    text: matchDto.isEnd
                        ? '경기종료'
                        : formatDateTimeToHourMinute(matchDto.startDate),
                    icon: GogoIcons.alarm(
                      color: GogoColors.success,
                      width: 12,
                      height: 12,
                    ),
                  ),
                  switch (matchDto.category) {
                    GameType.SOCCER => GogoIcons.football(
                        color: GogoColors.main500,
                        width: 18,
                        height: 18,
                      ),
                    GameType.BASKET_BALL => GogoIcons.basketball(
                        color: GogoColors.main500,
                        width: 18,
                        height: 18,
                      ),
                    GameType.BASE_BALL => GogoIcons.baseball(
                        color: GogoColors.main500,
                        width: 18,
                        height: 18,
                      ),
                    GameType.VOLLEY_BALL => GogoIcons.volleyball(
                        color: GogoColors.main500,
                        width: 18,
                        height: 18,
                      ),
                    GameType.BADMINTON => GogoIcons.badminton(
                        color: GogoColors.main500,
                        width: 18,
                        height: 18,
                      ),
                    GameType.LOL => GogoIcons.onlineGame(
                        color: GogoColors.main500,
                        width: 18,
                        height: 18,
                      ),
                    GameType.ETC => GogoIcons.volleyball(
                        color: GogoColors.main500,
                        width: 18,
                        height: 18,
                      ),
                  }
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(
                    PageRouter.matchDetail,
                    extra: matchDto,
                    pathParameters: {'matchId': matchDto.matchId.toString()},
                  );
                },
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
                    '${matchDto.ateam.bettingPoint + matchDto.bteam.bettingPoint}',
                    style: GogoTypography.caption1Semibold.copyWith(
                      color: GogoColors.gray300,
                    ),
                  ),
                ],
              ),
              matchDto.isEnd
                  ? Text(
                      "${matchDto.result?.victoryTeamId == matchDto.ateam.teamId ? matchDto.ateam.teamName : matchDto.bteam.teamName}팀 승리",
                      style: GogoTypography.body1Extrabold
                          .copyWith(color: GogoColors.white),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Text(
                            "${matchDto.ateam.teamName}팀",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: GogoTypography.body1Extrabold.copyWith(
                                color: matchDto.betting.isBetting &&
                                        matchDto.betting.predictedWinTeamId ==
                                            matchDto.ateam.teamId
                                    ? GogoColors.main500
                                    : GogoColors.white),
                          ),
                        ),
                        Text(
                          "VS",
                          style: GogoTypography.body2Extrabold
                              .copyWith(color: GogoColors.gray500),
                        ),
                        Expanded(
                          child: Text(
                            "${matchDto.bteam.teamName}팀",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: GogoTypography.body1Extrabold.copyWith(
                              color: matchDto.betting.isBetting &&
                                      matchDto.betting.predictedWinTeamId ==
                                          matchDto.bteam.teamId
                                  ? GogoColors.main500
                                  : GogoColors.white,
                            ),
                          ),
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
                          "${matchDto.result!.isPredictionSuccess! ? "+" : "-"}${matchDto.result!.earnedPoint.toString()}P",
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
                  onTap: onBattingClick,
                  text: matchDto.betting.isBetting
                      ? "${matchDto.betting.bettingPoint}P 배팅"
                      : "배팅",
                  textStyle: GogoTypography.caption1Semibold,
                  color: matchDto.isEnd || matchDto.betting.isBetting
                      ? GogoColors.gray400
                      : GogoColors.main600,
                )
        ],
      ),
    );
  }
}
