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
    return SizedBox(
      width: 240.w,
      height: 58.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 70.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12,
                children: [
                  GogoBorderlessTagComponent(
                    color: matchDto.aTeam.teamId ==
                            matchDto.betting.predictedWinTeamId
                        ? GogoColors.main500
                        : GogoColors.gray300,
                    text: '${matchDto.aTeam.bettingPoint}',
                    icon: GogoIcons.pointCircle(height: 16.sp, width: 16.sp),
                  ),
                  SizedBox(
                    width: 70.w,
                    child: Text(
                      '${matchDto.aTeam.teamName}팀',
                      overflow: TextOverflow.ellipsis,
                      style: GogoTypography.body2Extrabold.copyWith(
                        color: matchDto.aTeam.teamId ==
                                matchDto.betting.predictedWinTeamId
                            ? GogoColors.main500
                            : GogoColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 60.w,
              child: Column(
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
                        '${matchDto.aTeam.bettingPoint + matchDto.bTeam.bettingPoint}',
                    icon: GogoIcons.pointCircle(height: 16.sp, width: 16.sp),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 70.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  GogoBorderlessTagComponent(
                    color: matchDto.bTeam.teamId ==
                            matchDto.betting.predictedWinTeamId
                        ? GogoColors.main500
                        : GogoColors.gray300,
                    text: '${matchDto.bTeam.bettingPoint}',
                    icon: GogoIcons.pointCircle(height: 16.sp, width: 16.sp),
                  ),
                  SizedBox(
                    width: 70.w,
                    child: Text(
                      '${matchDto.bTeam.teamName}팀',
                      overflow: TextOverflow.ellipsis,
                      style: GogoTypography.body2Extrabold.copyWith(
                        color: matchDto.bTeam.teamId ==
                                matchDto.betting.predictedWinTeamId
                            ? GogoColors.main500
                            : GogoColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
