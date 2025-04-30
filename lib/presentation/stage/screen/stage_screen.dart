import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/enum_type/stage_type.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/router.dart';
import '../../../design_system/component/stage/gogo_stage_card_component.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 40,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '참여한 스테이지',
                        style: GogoTypography.body2Extrabold
                            .copyWith(color: GogoColors.white),
                      ),
                      GestureDetector(
                        onTap: () => context.pushNamed(PageRouter.createStage),
                        child: GogoTagComponent(
                          color: GogoColors.main400,
                          padding: const EdgeInsets.all(12.0),
                          borderRadius: BorderRadius.circular(8),
                          text: '스테이지 생성',
                          icon: GogoIcons.plusCircle(
                            color: GogoColors.main400,
                            width: 16,
                            height: 16,
                          ),
                          textStyle: GogoTypography.caption2Semibold,
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: padding,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    children: [
                      GogoStageCardComponent(
                        stage: Stage(
                          stageId: 1,
                          stageName: '스테이지 이름',
                          type: StageType.OFFICIAL,
                          status: StageStatus.CONFIRMED,
                          participantCount: 2,
                          isParticipating: true,
                          isMaintainer: true,
                          isPassCode: false,
                        ),
                        onTap: (){},
                      ),
                      GogoStageCardComponent(
                        stage: Stage(
                          stageId: 1,
                          stageName: '스테이지 이름',
                          type: StageType.FAST,
                          status: StageStatus.CONFIRMED,
                          participantCount: 2,
                          isParticipating: false,
                          isMaintainer: false,
                          isPassCode: false,
                        ),

                        onTap: (){},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Padding(
                  padding: padding,
                  child: Text(
                    '참여가능한 스테이지',
                    style: GogoTypography.body2Extrabold
                        .copyWith(color: GogoColors.white),
                  ),
                ),
                SingleChildScrollView(
                  padding: padding,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    children: [
                      GogoStageCardComponent(
                        stage: Stage(
                          stageId: 1,
                          stageName: '스테이지 이름',
                          type: StageType.OFFICIAL,
                          status: StageStatus.CONFIRMED,
                          participantCount: 2,
                          isParticipating: true,
                          isMaintainer: true,
                          isPassCode: true,
                        ),

                        onTap: (){},
                      ),GogoStageCardComponent(
                        stage: Stage(
                          stageId: 1,
                          stageName: '스테이지 이름',
                          type: StageType.OFFICIAL,
                          status: StageStatus.CONFIRMED,
                          participantCount: 2,
                          isParticipating: true,
                          isMaintainer: true,
                          isPassCode: false,
                        ),

                        onTap: (){},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: padding,
                  child: Text(
                    '모집중인 스테이지',
                    style: GogoTypography.body2Extrabold
                        .copyWith(color: GogoColors.white),
                  ),
                ),
                SingleChildScrollView(
                  padding: padding,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    children: [
                      GogoStageCardComponent(
                        stage: Stage(
                          stageId: 1,
                          stageName: '스테이지 이름',
                          type: StageType.OFFICIAL,
                          status: StageStatus.CONFIRMED,
                          participantCount: 2,
                          isParticipating: true,
                          isMaintainer: true,
                          isPassCode: false,
                        ),

                        onTap: (){},
                      ),
                      GogoStageCardComponent(
                        stage: Stage(
                          stageId: 1,
                          stageName: '스테이지 이름',
                          type: StageType.OFFICIAL,
                          status: StageStatus.CONFIRMED,
                          participantCount: 2,
                          isParticipating: true,
                          isMaintainer: true,
                          isPassCode: true,
                        ),

                        onTap: (){},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
