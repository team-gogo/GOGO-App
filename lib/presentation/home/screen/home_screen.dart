import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/widgets/community_item.dart';
import 'package:gogo_app/presentation/home/widgets/appbar/home_appbar.dart';
import 'package:gogo_app/presentation/ranking/widgets/ranking_list_item.dart';
import 'package:intl/intl.dart';
import '../../../design_system/component/tag/gogo_tag_component.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../widgets/match_card/match_card_component.dart';
import '../widgets/minigame/minigame_play_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                            MatchCardComponent(
                              time: GogoTagComponent.small(
                                color: GogoColors.success,
                                text: "12:00",
                                icon: GogoIcons.alarm(
                                  color: GogoColors.success,
                                  width: 12,
                                  height: 12,
                                ),
                              ),
                              round: GogoTagComponent.small(
                                color: GogoColors.white,
                                text: "12강",
                                icon: GogoIcons.trophy(
                                    color: GogoColors.white,
                                    width: 12,
                                    height: 12),
                              ),
                              event: GogoTagComponent.small(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: GogoColors.main500,
                                text: "배드민턴",
                                icon: GogoIcons.volleyball(
                                    color: GogoColors.main500,
                                    width: 12,
                                    height: 12),
                              ),
                              point: '10000P',
                              teamA: "A",
                              teamB: 'B',
                            ),
                            EndedMatchCardComponent(
                              round: GogoTagComponent.small(
                                color: GogoColors.white,
                                text: "12강",
                                icon: GogoIcons.trophy(
                                    color: GogoColors.white,
                                    width: 12,
                                    height: 12),
                              ),
                              event: GogoTagComponent.small(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: GogoColors.main500,
                                text: "배드민턴",
                                icon: GogoIcons.volleyball(
                                    color: GogoColors.main500,
                                    width: 12,
                                    height: 12),
                              ),
                              point: '10000P',
                              winner: "A",
                              earnedPoint: -1000,
                              isPredictionSuccess: false,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      _itemTopBar(GogoIcons.arcade(color: GogoColors.white),
                          text: '미니게임'),
                      MinigamePlayComponent()
                    ],
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      _itemTopBar(
                        GogoIcons.trophy(color: GogoColors.white),
                        text: '포인트 랭킹',
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
                      )
                    ],
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      _itemTopBar(
                        GogoIcons.community(color: GogoColors.white),
                        text: '커뮤니티',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          spacing: 8,
                          children: List.generate(
                            5,
                            (index) => CommunityItem(
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
