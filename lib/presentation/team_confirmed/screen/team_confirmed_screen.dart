import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/team_confirmed/bloc/confirm/stage_confirm_bloc.dart';
import 'package:gogo_app/presentation/team_confirmed/bloc/data/get_temp_team_event.dart';
import 'package:gogo_app/presentation/team_confirmed/widget/team_confirmed_widget.dart';

import '../../../data/models/stage/handle_stage/stage_confirm_request.dart';
import '../../../data/models/stage/search_stage/search_team_temp_response.dart';
import '../../loading/screens/loadaing_page.dart';
import '../bloc/confirm/stage_confirm_event.dart';
import '../bloc/confirm/stage_confirm_state.dart';
import '../bloc/data/get_temp_team_bloc.dart';
import '../bloc/data/get_temp_team_state.dart';
import '../bloc/widget/team_select_bloc.dart';
import '../bloc/widget/team_select_event.dart';
import '../bloc/widget/team_select_state.dart';

class TeamConfirmedScreen extends StatelessWidget {
  final int stageId;
  final int gameId;

  const TeamConfirmedScreen(
      {super.key, required this.gameId, required this.stageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) =>
                    GetTempTeamBloc()..add(GetTempTeamEvent(gameId: gameId))),
            BlocProvider(create: (_) => TeamSelectBloc()),
            BlocProvider(create: (_) => StageConfirmBloc()), // 추가하고 싶은 Bloc
          ],
          child: BlocBuilder<GetTempTeamBloc, GetTempTeamState>(
            builder: (context, state) {
              if (state is GetTempTeamLoading || state is GetTempTeamInitial) {
                return LoadingPage();
              }

              if (state is GetTempTeamError) {
                return Center(child: Text('에러 발생: ${state.message}'));
              }

              final teams = (state as GetTempTeamLoaded).tempTeamResponse.team;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GogoTopBar(title: '경기 이름', onBackTap: context.pop),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<TeamSelectBloc, TeamSelectState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('현제 등록된 팀들',
                                style: GogoTypography.caption1Extrabold
                                    .copyWith(color: GogoColors.white)),
                            Row(
                              children: [
                                Text('선택된 팀 개수',
                                    style: GogoTypography.caption3Semibold
                                        .copyWith(color: GogoColors.gray500)),
                                SizedBox(width: 10),
                                Text('${state.selectedTeamIds.length}',
                                    style: GogoTypography.caption2Semibold
                                        .copyWith(color: GogoColors.white)),
                                SizedBox(width: 12),
                                GogoTagComponent(
                                    icon: GogoIcons.check(
                                        color: GogoColors.main500),
                                    color: GogoColors.main500,
                                    text: '팀확정 하기',
                                    ontap: () {}),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: BlocBuilder<TeamSelectBloc, TeamSelectState>(
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(
                              children: teams.map((team) {
                                final isSelected =
                                    state.selectedTeamIds.contains(team.teamId);
                                return TeamConfirmedWidget(
                                  team: team,
                                  isSelected: isSelected,
                                  onTap: () {
                                    context
                                        .read<TeamSelectBloc>()
                                        .add(ToggleTeamSelection(team.teamId));
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
