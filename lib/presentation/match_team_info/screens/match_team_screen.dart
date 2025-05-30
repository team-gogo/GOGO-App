import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/create_stage/game.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/loading/screens/loadaing_page.dart';
import 'package:gogo_app/presentation/match_team_info/bloc/match_team_bloc.dart';
import 'package:gogo_app/presentation/match_team_info/bloc/match_team_event.dart';
import 'package:gogo_app/presentation/match_team_info/bloc/match_team_state.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_list.dart';
import '../../../design_system/theme/color.dart';

class MatchTeamInfoScreen extends StatefulWidget {
  const MatchTeamInfoScreen(
      {super.key, required this.stageId, required this.gameIndex});

  final int stageId;
  final int gameIndex;

  @override
  State<MatchTeamInfoScreen> createState() => _MatchTeamInfoScreenState();
}

class _MatchTeamInfoScreenState extends State<MatchTeamInfoScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MatchTeamBloc()..add(GetGameList(stageId: widget.stageId)),
      child: BlocBuilder<MatchTeamBloc, MatchTeamState>(
        builder: (context, state) {
          if (state is LoadedMatchTeam) {
            _tabController ??=
                TabController(length: state.gameResponse.count, vsync: this);
            _tabController?.animateTo(widget.gameIndex);
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          GogoTopBar(
                              title: '경기 팀 보기',
                              onBackTap: () => context.pop(context)),
                          SizedBox(height: 18),
                          TabBar(
                            dividerColor: GogoColors.black,
                            indicatorColor: GogoColors.main600,
                            labelColor: GogoColors.white,
                            labelStyle: GogoTypography.caption1Extrabold,
                            unselectedLabelStyle:
                                GogoTypography.caption1Extrabold,
                            overlayColor: WidgetStatePropertyAll(
                                GogoColors.main600.withOpacity(0.2)),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 2,
                            labelPadding: EdgeInsets.fromLTRB(6, 0, 6, 10),
                            controller: _tabController,
                            tabs: List.generate(
                              state.gameResponse.games.length,
                              (index) => Tab(
                                text: state.gameResponse.games[index].gameName,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: List.generate(
                          state.gameResponse.count,
                          (index) => MatchTeamList(
                            teamResponse: state.teamResponse[index],
                            game: state.gameResponse.games[index].category,
                            isTournament:
                                state.gameResponse.games[index].system ==
                                    GameSystem.TOURNAMENT,
                            gameId: state.gameResponse.games[index].gameId,
                            onRefresh: () async => context
                                .read<MatchTeamBloc>()
                                .add(GetGameList(stageId: widget.stageId)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is InitMatchTeam || state is LoadingMatchTeam) {
            return LoadingPage();
          } else {
            return Scaffold(
              body: Center(
                child: Text(
                  '잘못된 접근입니다.',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
