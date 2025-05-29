import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/team_confirmed/bloc/data/get_temp_team_event.dart';
import 'package:gogo_app/presentation/team_confirmed/widget/team_confirmed_widget.dart';

import '../../../data/models/stage/search_stage/search_team_temp_response.dart';
import '../../loading/screens/loadaing_page.dart';
import '../bloc/data/get_temp_team_bloc.dart';
import '../bloc/data/get_temp_team_state.dart';
import '../bloc/widget/team_select_bloc.dart';
import '../bloc/widget/team_select_event.dart';
import '../bloc/widget/team_select_state.dart';

class TeamConfirmedScreen extends StatelessWidget {
  final int gameId;

  const TeamConfirmedScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              GetTempTeamBloc()..add(GetTempTeamEvent(gameId: gameId)),
          child: BlocBuilder<GetTempTeamBloc, GetTempTeamState>(
            builder: (context, state) {
              if (state is GetTempTeamLoading || state is GetTempTeamInitial) {
                return LoadingPage();
              }
              // Game 목록과 개수를 상태에서 가져오기
              List<TempTeam> teams = [];
              if (state is GetTempTeamLoaded) {
                teams = state.tempTeamResponse.team;
              } else if (state is GetTempTeamError) {
                return Center(child: Text('에러 발생: ${state.message}'));
              }

              return BlocProvider(
                create: (_) => TeamSelectBloc(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GogoTopBar(title: '경기 이름', onBackTap: () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BlocBuilder<TeamSelectBloc, TeamSelectState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '현제 등록된 팀들',
                                style: GogoTypography.caption1Extrabold
                                    .copyWith(color: GogoColors.white),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '선택된 팀 개수',
                                    style: GogoTypography.caption3Semibold
                                        .copyWith(color: GogoColors.gray500),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${state.selectedTeamIds.length}',
                                    style: GogoTypography.caption2Semibold
                                        .copyWith(color: GogoColors.white),
                                  ),
                                  SizedBox(width: 12),
                                  GogoTagComponent(
                                    icon: GogoIcons.check(
                                        color: GogoColors.main500),
                                    color: GogoColors.main500,
                                    text: '팀확정 하기',
                                  )
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
                                  final isSelected = state.selectedTeamIds
                                      .contains(team.teamId);
                                  return TeamConfirmedWidget(
                                    team: team,
                                    isSelected: isSelected,
                                    onTap: () {
                                      context.read<TeamSelectBloc>().add(
                                          ToggleTeamSelection(team.teamId));
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
