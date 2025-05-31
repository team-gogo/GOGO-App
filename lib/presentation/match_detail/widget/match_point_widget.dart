import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/tag/gogo_borderless_tag_component.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

import '../../../data/models/common/match_dto.dart';

class MatchPointWidget extends StatelessWidget {
  final MatchDto matchDto;

  const MatchPointWidget({super.key, required this.matchDto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 67),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                GogoBorderlessTagComponent(
                  color: matchDto.ateam.teamId ==
                          matchDto.betting.predictedWinTeamId
                      ? GogoColors.main500
                      : GogoColors.gray300,
                  text: '${matchDto.ateam.bettingPoint}',
                  icon: GogoIcons.pointCircle(height: 16, width: 16),
                ),
                SizedBox(
                  child: Text(
                    '${matchDto.ateam.teamName}팀',
                    overflow: TextOverflow.ellipsis,
                    style: GogoTypography.body2Extrabold.copyWith(
                      color: matchDto.ateam.teamId ==
                              matchDto.betting.predictedWinTeamId
                          ? GogoColors.main500
                          : GogoColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Text(
                  '총 포인트',
                  style: GogoTypography.body3Semibold
                      .copyWith(color: GogoColors.white),
                ),
                GogoBorderlessTagComponent(
                  spacing: 8,
                  color: GogoColors.white,
                  text:
                      '${matchDto.ateam.bettingPoint + matchDto.bteam.bettingPoint}',
                  icon: GogoIcons.pointCircle(height: 16, width: 16),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                GogoBorderlessTagComponent(
                  color: matchDto.bteam.teamId ==
                          matchDto.betting.predictedWinTeamId
                      ? GogoColors.main500
                      : GogoColors.gray300,
                  text: '${matchDto.bteam.bettingPoint}',
                  icon: GogoIcons.pointCircle(height: 16, width: 16),
                ),
                SizedBox(
                  child: Text(
                    '${matchDto.bteam.teamName}팀',
                    overflow: TextOverflow.ellipsis,
                    style: GogoTypography.body2Extrabold.copyWith(
                      color: matchDto.bteam.teamId ==
                              matchDto.betting.predictedWinTeamId
                          ? GogoColors.main500
                          : GogoColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
