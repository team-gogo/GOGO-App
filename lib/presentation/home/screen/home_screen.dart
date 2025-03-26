import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/widgets/community_item.dart';
import 'package:gogo_app/presentation/home/widgets/appbar/home_appbar.dart';
import 'package:gogo_app/presentation/ranking/widgets/ranking_list_item.dart';
import 'package:gogo_app/router.dart';
import 'package:intl/intl.dart';
import '../../../data/models/common/match_dto.dart';
import '../../../data/models/stage/enum_type/match_round.dart';
import '../../../data/models/stage/enum_type/system_type.dart';
import '../../../data/models/stage/search_stage/search_betting_stage_response.dart';
import '../../../design_system/component/tag/gogo_tag_component.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../widgets/match_card/match_card_component.dart';
import '../widgets/minigame/minigame_play_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final EdgeInsets padding = EdgeInsets.symmetric(horizontal: 16);

  Widget _itemTopBar(Widget gogoIcon, {
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
    return Scaffold(
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
                                )
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
                                (index) =>
                                RankingListItem(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          spacing: 8,
                          children: List.generate(
                            5,
                                (index) =>
                                CommunityItem(
                                  name: '홍길동',
                                  gameType: GameType.BADMINTON,
                                  title: '김진원 김진원 김진원 김진원',
                                  commentNum: 10,
                                  likeNum: 10,
                                ),
                          ),
                        ),
                      )
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
    );
  }
}
