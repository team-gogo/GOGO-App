import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/community/community_search_request_query_string.dart';
import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_bloc.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_state.dart';
import 'package:gogo_app/presentation/community/bloc/main/community_bloc.dart';
import 'package:gogo_app/presentation/community/bloc/main/community_event.dart';
import 'package:gogo_app/presentation/community/bloc/main/community_state.dart';
import 'package:gogo_app/presentation/community/screen/community_detail_screen.dart';
import 'package:gogo_app/presentation/community/widgets/community_item.dart';
import 'package:gogo_app/presentation/home/widgets/appbar/home_appbar.dart';
import 'package:gogo_app/presentation/ranking/widgets/ranking_list_item.dart';
import 'package:gogo_app/router.dart';
import 'package:intl/intl.dart';
import '../../../data/models/common/match_dto.dart';
import '../../../data/models/stage/enum_type/match_round.dart';
import '../../../data/models/stage/enum_type/system_type.dart';
import '../../../data/models/stage/search_stage/search_betting_stage_response.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../ranking/bloc/ranking_bloc.dart';
import '../../ranking/bloc/ranking_event.dart';
import '../widgets/match_card/match_card_component.dart';
import '../widgets/minigame/minigame_play_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.stageId});

  final int stageId;

  static final EdgeInsets padding = EdgeInsets.symmetric(horizontal: 16);

  Widget _itemTopBar(
    Widget gogoIcon, {
    String? text,
    DateTime? date,
    VoidCallback? onTap,
  }) =>
      Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                gogoIcon,
                SizedBox(width: 8),
                Text(
                  date != null
                      ? '${DateFormat('MM-dd').format(date)} 매치'
                      : '$text',
                  style: GogoTypography.body2Extrabold.copyWith(
                    color: GogoColors.white,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: onTap ?? () {},
              child: Container(
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Text(
                      '더보기',
                      style: GogoTypography.caption1Semibold
                          .copyWith(color: GogoColors.gray500),
                    ),
                    SizedBox(width: 8),
                    GogoIcons.chevronRight(
                      color: GogoColors.gray500,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => CommunityBloc(
        stageId: stageId,
      )
        ..add(
          FetchCommunityEvent(
            queryString: CommunitySearchRequestQueryString(
              page: 0,
              size: 15,
              type: null,
              sort: SortType.LATEST,
            ),
          ),
        ),)
      ],
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: HomeAppbar(point: 1000),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 40,
                  children: [
                    Column(
                      spacing: 16,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        _itemTopBar(
                          GogoIcons.clock(color: GogoColors.white),
                          date: DateTime.now(),
                        ),
                        SingleChildScrollView(
                          padding: padding,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 8,
                            children: [
                              MatchCard(
                                matchDto: MatchDto(
                                  matchId: 1,
                                  aTeam: MatchTeam(
                                    teamId: 101,
                                    teamName: "Team A",
                                    bettingPoint: 500,
                                    winCount: 10,
                                  ),
                                  bTeam: MatchTeam(
                                    teamId: 102,
                                    teamName: "Team B",
                                    bettingPoint: 600,
                                    winCount: 12,
                                  ),
                                  startDate: DateTime(2024, 3, 25, 18, 30),
                                  endDate: DateTime(2024, 3, 25, 20, 30),
                                  isEnd: true,
                                  round: MatchRound.SEMI_FINALS,
                                  category: GameType.LOL,
                                  gameName: "Champions League",
                                  system: System.TOURNAMENT,
                                  turn: 1,
                                  isNotice: true,
                                  betting: Betting(
                                    isBetting: true,
                                    bettingPoint: 2001,
                                    predictedWinTeamId: 101,
                                  ),
                                  result: MatchResult(
                                    victoryTeamId: 102,
                                    aTeamScore: 1,
                                    bTeamScore: 2,
                                    isPredictionSuccess: true,
                                    earnedPoint: 300,
                                    tempPointExpiredDate: DateTime(2024, 6, 1),
                                  ),
                                ),
                                onBattingClick: () {},
                              ),
                              MatchCard(
                                matchDto: MatchDto(
                                  matchId: 1,
                                  aTeam: MatchTeam(
                                    teamId: 101,
                                    teamName: "Team A",
                                    bettingPoint: 500,
                                    winCount: 10,
                                  ),
                                  bTeam: MatchTeam(
                                    teamId: 102,
                                    teamName: "Team B",
                                    bettingPoint: 600,
                                    winCount: 12,
                                  ),
                                  startDate: DateTime(2024, 3, 25, 18, 30),
                                  endDate: DateTime(2024, 3, 25, 20, 30),
                                  isEnd: true,
                                  round: MatchRound.SEMI_FINALS,
                                  category: GameType.LOL,
                                  gameName: "Champions League",
                                  system: System.TOURNAMENT,
                                  turn: 1,
                                  isNotice: true,
                                  betting: Betting(
                                    isBetting: true,
                                    bettingPoint: 2001,
                                    predictedWinTeamId: 101,
                                  ),
                                  result: MatchResult(
                                    victoryTeamId: 102,
                                    aTeamScore: 1,
                                    bTeamScore: 2,
                                    isPredictionSuccess: false,
                                    earnedPoint: 300,
                                    tempPointExpiredDate: DateTime(2024, 6, 1),
                                  ),
                                ),
                                onBattingClick: () {},
                              ),
                              MatchCard(
                                matchDto: MatchDto(
                                  matchId: 1,
                                  aTeam: MatchTeam(
                                    teamId: 101,
                                    teamName: "Team A",
                                    bettingPoint: 500,
                                    winCount: 10,
                                  ),
                                  bTeam: MatchTeam(
                                    teamId: 102,
                                    teamName: "Team B",
                                    bettingPoint: 600,
                                    winCount: 12,
                                  ),
                                  startDate: DateTime(2024, 3, 25, 18, 30),
                                  endDate: DateTime(2024, 3, 25, 20, 30),
                                  isEnd: false,
                                  round: MatchRound.SEMI_FINALS,
                                  category: GameType.LOL,
                                  gameName: "Champions League",
                                  system: System.TOURNAMENT,
                                  turn: 1,
                                  isNotice: true,
                                  betting: Betting(
                                    isBetting: true,
                                    bettingPoint: 2001,
                                    predictedWinTeamId: 101,
                                  ),
                                  result: MatchResult(
                                    victoryTeamId: 102,
                                    aTeamScore: 1,
                                    bTeamScore: 2,
                                    isPredictionSuccess: true,
                                    earnedPoint: 300,
                                    tempPointExpiredDate: DateTime(2024, 6, 1),
                                  ),
                                ),
                                onBattingClick: () {},
                              ),
                              MatchCard(
                                matchDto: MatchDto(
                                  matchId: 1,
                                  aTeam: MatchTeam(
                                    teamId: 101,
                                    teamName: "Team A",
                                    bettingPoint: 2001,
                                    winCount: 10,
                                  ),
                                  bTeam: MatchTeam(
                                    teamId: 102,
                                    teamName: "Team B",
                                    bettingPoint: 2001,
                                    winCount: 12,
                                  ),
                                  startDate: DateTime(2024, 3, 25, 18, 30),
                                  endDate: DateTime(2024, 3, 25, 20, 30),
                                  isEnd: false,
                                  round: MatchRound.SEMI_FINALS,
                                  category: GameType.LOL,
                                  gameName: "Champions League",
                                  system: System.TOURNAMENT,
                                  turn: 1,
                                  isNotice: true,
                                  betting: Betting(
                                    isBetting: false,
                                    bettingPoint: 2001,
                                    predictedWinTeamId: 101,
                                  ),
                                ),
                                onBattingClick: () {},
                              ),
                              onBattingClick: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      _itemTopBar(GogoIcons.arcade(color: GogoColors.white),
                          text: '미니게임',
                          onTap: () =>
                              context.pushNamed(PageRouter.miniGame)),
                      MinigamePlayComponent()
                    ],
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      _itemTopBar(
                        GogoIcons.trophy(color: GogoColors.white),
                        text: '포인트 랭킹',
                        onTap: () => context.pushNamed(
                          PageRouter.ranking,
                          pathParameters: {'stageId': stageId.toString()},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          spacing: 8,
                          children: List.generate(
                            5,
                            (index) => RankingListItem(
                                index: index, name: '홍길동', point: 100),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 16,
                      children: [
                        _itemTopBar(GogoIcons.arcade(color: GogoColors.white),
                            text: '미니게임',
                            onTap: () => context.pushNamed(PageRouter.miniGame)),
                        MinigamePlayComponent()
                      ],
                    ),
                    Column(
                      spacing: 16,
                      children: [
                        _itemTopBar(GogoIcons.trophy(color: GogoColors.white),
                            text: '포인트 랭킹',
                            onTap: () => context.pushNamed(PageRouter.ranking)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            spacing: 8,
                            children: List.generate(
                              5,
                              (index) => RankingListItem(
                                  index: index, name: '홍길동', point: 100),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                          spacing: 16,
                          children: [
                            _itemTopBar(
                              GogoIcons.community(color: GogoColors.white),
                              text: '커뮤니티',
                              onTap: () => context.pushNamed(PageRouter.community),
                            ),
                            BlocBuilder<CommunityBloc,CommunityState>(
                              builder: (context,state) {
                                switch (state){
                                  case CommunityLoadingState _:
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: GogoColors.main600,
                                    ),
                                  );
                                  break;
                                  case CommunityLoadedState _:
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        spacing: 8,
                                        children: List.generate(
                                          5,
                                          (index) => CommunityItem(
                                            ontap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityDetailScreen(boardId: state.response.board[index].boardId)),);
                                            },
                                            name: "익명",
                                            gameType: state.response.board[index].gameCategory,
                                            title: state.response.board[index].title,
                                            commentNum: state.response.board[index].commentCount,
                                            likeNum: state.response.board[index].likeCount,
                                          ),
                                        ),
                                      ),
                                    );
                                    case CommunityErrorState _:
                                    return Text(state.message,style: TextStyle(color: Colors.white),);

                                    default:
                                    return Text("값 없음");
                                } 
                              }
                            ),
                          ],
                        ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
