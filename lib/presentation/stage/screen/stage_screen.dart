import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/presentation/loadaing_page.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_bloc.dart';
import 'package:gogo_app/router.dart';
import '../../../design_system/component/stage/gogo_stage_card_component.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';
import '../bloc/stage_event.dart';
import '../bloc/stage_state.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StageBloc()..add(GetStageEvent()),
      child: BlocBuilder<StageBloc, StageState>(
        builder: (context, state) {
          if (state is StageLoading) {
            return LoadingPage();
          } else if (state is StageLoaded) {
            List<Stage> participatedStages = [];
            List<Stage> recruitingStage = [];
            List<Stage> confirmedStages = [];
            for (int i = 0; i < state.stage.count; i++) {
              if (state.stage.stages[i].isParticipating) {
                participatedStages.add(state.stage.stages[i]);
              }
              if (state.stage.stages[i].status == StageStatus.CONFIRMED) {
                confirmedStages.add(state.stage.stages[i]);
              }
              if (state.stage.stages[i].status == StageStatus.RECRUITING) {
                recruitingStage.add(state.stage.stages[i]);
              }
            }
            return Scaffold(
              body: RefreshIndicator(
                color: GogoColors.main600,
                backgroundColor: GogoColors.gray700,
                onRefresh: () async {
                  return context.read<StageBloc>().add(GetStageEvent());
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  onTap: () =>
                                      context.pushNamed(PageRouter.createStage),
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
                              children: List.generate(
                                participatedStages.length,
                                (index) => GogoStageCardComponent(
                                  stage: participatedStages[index],
                                  color: GogoColors.gray700,
                                  broadcast: false,
                                ),
                              ),
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
                              children: List.generate(
                                confirmedStages.length,
                                (index) => GogoStageCardComponent(
                                  stage: confirmedStages[index],
                                  color: GogoColors.gray700,
                                  broadcast: false,
                                ),
                              ),
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
                              children: List.generate(
                                recruitingStage.length,
                                (index) => GogoStageCardComponent(
                                  stage: recruitingStage[index],
                                  color: GogoColors.gray700,
                                  broadcast: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text(
                  'Error: ${state.toString()}',
                  style: GogoTypography.body2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
