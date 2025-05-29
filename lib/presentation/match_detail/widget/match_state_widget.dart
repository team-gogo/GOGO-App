import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/data/models/stage/enum_type/match_round.dart';
import 'package:gogo_app/design_system/component/tag/gogo_borderless_tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';

import '../../../data/models/stage/enum_type/game_type.dart';
import '../../../data/models/stage/enum_type/system_type.dart';
import '../../../data/util/data_time_formatter.dart';
import '../../../design_system/theme/color.dart';

class MatchStateWidget extends StatelessWidget {
  final MatchDto matchDto;

  const MatchStateWidget({super.key, required this.matchDto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 48),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GogoColors.gray700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          matchDto.isNotice
              ? GogoIcons.enabledBell(color: GogoColors.main500)
              : GogoIcons.bell(color: GogoColors.gray400),
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
            color: matchDto.isEnd ? GogoColors.gray500 : GogoColors.white,
            text: matchDto.isEnd
                ? '경기종료'
                : formatDateTimeToHourMinute(matchDto.startDate),
            icon: GogoIcons.alarm(
              color: GogoColors.success,
              width: 12,
              height: 12,
            ),
          ),
          GogoBorderlessTagComponent(
            color: GogoColors.main500,
            spacing: 8,
            text: switch (matchDto.category) {
              GameType.SOCCER => '축구',
              GameType.BASKET_BALL => '농구',
              GameType.BASE_BALL => '야구',
              GameType.VOLLEY_BALL => '배구',
              GameType.BADMINTON => '베드민턴',
              GameType.LOL => '리그오브레전드',
              GameType.ETC => '기타',
            },
            icon: switch (matchDto.category) {
              GameType.SOCCER => GogoIcons.football(
                  width: 16,
                  height: 16,
                ),
              GameType.BASKET_BALL => GogoIcons.basketball(
                  width: 16,
                  height: 16,
                ),
              GameType.BASE_BALL => GogoIcons.baseball(
                  width: 16,
                  height: 16,
                ),
              GameType.VOLLEY_BALL => GogoIcons.volleyball(
                  width: 16,
                  height: 16,
                ),
              GameType.BADMINTON => GogoIcons.badminton(
                  width: 16,
                  height: 16,
                ),
              GameType.LOL => GogoIcons.onlineGame(
                  width: 16,
                  height: 16,
                ),
              GameType.ETC => GogoIcons.volleyball(width: 16, height: 16),
            },
          )
        ],
      ),
    );
  }
}
