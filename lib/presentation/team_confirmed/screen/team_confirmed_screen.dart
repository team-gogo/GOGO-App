import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/team_confirmed/widget/team_confirmed_widget.dart';

import '../../../data/models/stage/search_stage/search_team_temp_response.dart';
import '../bloc/widget/team_select_bloc.dart';
import '../bloc/widget/team_select_event.dart';
import '../bloc/widget/team_select_state.dart';

class TeamConfirmedScreen extends StatelessWidget {
  TeamConfirmedScreen({super.key});

  final List<TempTeam> teams = [
    TempTeam(teamId: 1, teamName: '팀 이름1', participantCount: 1),
    TempTeam(teamId: 2, teamName: '팀 이름2', participantCount: 2),
    TempTeam(teamId: 3, teamName: '팀 이름3', participantCount: 3),
    TempTeam(teamId: 4, teamName: '팀 이름4', participantCount: 4),
    TempTeam(teamId: 5, teamName: '팀 이름5', participantCount: 5),
    TempTeam(teamId: 6, teamName: '팀 이름6', participantCount: 6),
    TempTeam(teamId: 7, teamName: '팀 이름7', participantCount: 7),
    TempTeam(teamId: 8, teamName: '팀 이름8', participantCount: 8),
    TempTeam(teamId: 9, teamName: '팀 이름9', participantCount: 9),
    TempTeam(teamId: 10, teamName: '팀 이름10', participantCount: 10),
    TempTeam(teamId: 11, teamName: '팀 이름11', participantCount: 11),
    TempTeam(teamId: 12, teamName: '팀 이름12', participantCount: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
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
                              icon: GogoIcons.check(color: GogoColors.main500),
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
          ),
        ),
      ),
    );
  }
}

