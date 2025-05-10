import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/enum_type/stage_type.dart';
import 'package:gogo_app/data/models/stage/handle_stage/join_stage_request.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/component/tag/gogo_borderless_tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_bloc.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_event.dart';
import 'package:gogo_app/router.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';

class GogoStageCardComponent extends StatelessWidget {
  final Color color;
  final Stage stage;
  final bool broadcast;

  const GogoStageCardComponent(
      {super.key,
      this.color = GogoColors.gray700,
      this.broadcast = false,
      required this.stage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: GogoColors.gray700,
      ),
      width: 343.w,
      child: Column(
        spacing: 28,
        children: [
          Row(
            spacing: 12,
            children: [
              stage.type == StageType.OFFICIAL
                  ? GogoBorderlessTagComponent(
                      color: GogoColors.white,
                      text: '공식',
                      textStyle: GogoTypography.caption2Extrabold,
                      icon: GogoIcons.trophy(
                        width: 16,
                        height: 16,
                      ),
                    )
                  : SizedBox.shrink(),
              GogoBorderlessTagComponent(
                color: stage.isParticipating
                    ? GogoColors.white
                    : GogoColors.gray500,
                text: stage.isParticipating ? '모집 중' : '모집 확정',
                textStyle: GogoTypography.caption2Extrabold,
                icon: GogoIcons.stage(
                  width: 16,
                  height: 16,
                ),
              ),
              stage.isMaintainer
                  ? GogoBorderlessTagComponent(
                      color: GogoColors.main500,
                      text: '관리자',
                      textStyle: GogoTypography.caption2Extrabold,
                      icon: GogoIcons.gearWheel(
                        width: 16,
                        height: 16,
                      ),
                    )
                  : SizedBox.shrink(),
              stage.participantCount != 0
                  ? GogoBorderlessTagComponent(
                      color: GogoColors.main500,
                      text: '${stage.participantCount}',
                      textStyle: GogoTypography.caption2Extrabold,
                      icon: GogoIcons.person(
                        width: 16,
                        height: 16,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          Text(
            stage.stageName,
            style:
                GogoTypography.body2Extrabold.copyWith(color: GogoColors.white),
          ),
          stage.isPassCode
              ? SizedBox(
                  height: 45,
                  child: GogoIconButton(
                      textStyle: GogoTypography.caption1Semibold,
                      icon: GogoIcons.lock(
                        height: 20.sp,
                        width: 20.sp,
                        color: GogoColors.white,
                      ),
                      onTap: () {
                        context.read<StageBloc>().add(EnterStageEvent(
                            stageId: stage.stageId, body: JoinStageRequest()));
                      },
                      text: '인증번호로 참여하기'),
                )
              : SizedBox(
                  height: 45,
                  child: GogoDefaultButton(
                    onTap: () {
                      if (!stage.isParticipating) {
                        context.read<StageBloc>().add(EnterStageEvent(
                            stageId: stage.stageId, body: JoinStageRequest()));
                      }
                      context.goNamed('home');
                    },
                    text: '참여하기',
                    textStyle: GogoTypography.caption1Semibold,
                  ),
                  onTap: () {
                    context.read<StageBloc>().add(EnterStageEvent(
                        stageId: stage.stageId, body: JoinStageRequest()));
                  },
                  text: '인증번호로 참여하기')
              : GogoDefaultButton(
                  onTap: () {
                    if (!stage.isParticipating) {
                      context.read<StageBloc>().add(EnterStageEvent(
                          stageId: stage.stageId, body: JoinStageRequest()));
                    }
                    context.goNamed(
                      PageRouter.home,
                      pathParameters: {'stageId': stage.stageId.toString()},
                    );
                  },
                  text: '참여하기',
                  textStyle: GogoTypography.caption1Semibold,
                ),
        ],
      ),
    );
  }
}
