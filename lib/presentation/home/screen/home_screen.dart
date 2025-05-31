import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/indicator/refresh_indicator.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/screen/community_detail_screen.dart';
import 'package:gogo_app/presentation/community/widgets/community_item.dart';
import 'package:gogo_app/presentation/home/bloc/home_bloc.dart';
import 'package:gogo_app/presentation/home/widgets/appbar/home_appbar.dart';
import 'package:gogo_app/presentation/home/widgets/bankruptcy_modal/bankruptcy_modal.dart';
import 'package:gogo_app/presentation/home/widgets/match_game_item.dart';
import 'package:gogo_app/presentation/loading/screens/loadaing_page.dart';
import 'package:gogo_app/presentation/navigation_view/widgets/drawer/gogo_drawer.dart';
import 'package:gogo_app/presentation/ranking/widgets/ranking_list_item.dart';
import 'package:gogo_app/router.dart';
import 'package:intl/intl.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/match_card/match_card_component.dart';
import '../widgets/minigame/minigame_play_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.stageId});

  final int? stageId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(stageId: stageId!),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) async {
          if (state is LoadedHomeState) {
            print(state.isBankruptcy);
            if (state.isBankruptcy) {
              final request = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (builder) => BankruptcyModal());
              final bool response = request['isCheck'] ?? false;
              context.read<HomeBloc>().add(CheckBankruptcy(response));
            }
          }
        },
        builder: (BuildContext context, HomeState state) {
          if (state is LoadingHomeState ||
              state is InitialHomeState ||
              state is LoadingMatchHomeState) {
            return LoadingPage();
          } else if (state is LoadedHomeState) {
            return Scaffold(
              endDrawer: GogoDrawer(
                stageId: stageId!,
              ),
              body: SafeArea(
                child: GogoRefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(LoadHome());
                    await Future.delayed(Duration(seconds: 1));
                  },
                  child: Column(
                    children: [
                      HomeAppbar(
                        point: state.points.point,
                        selectedDate: context.read<HomeBloc>().selectedDate,
                        setSelectedDate: (DateTime date) => {
                          context.read<HomeBloc>().add(LoadMatchesByDate(date))
                        },
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 40,
                            children: [
                              Column(
                                spacing: 16,
                                children: [
                                  SizedBox(height: 8),
                                  _itemTopBar(
                                      GogoIcons.clock(color: GogoColors.white),
                                      date:
                                          context.read<HomeBloc>().selectedDate,
                                      onTap: () => context.pushNamed(
                                              PageRouter.matchList,
                                              queryParameters: {
                                                'stageId': stageId.toString(),
                                                'year': DateFormat('yyyy')
                                                    .format(context
                                                        .read<HomeBloc>()
                                                        .selectedDate),
                                                'month': DateFormat('MM')
                                                    .format(context
                                                        .read<HomeBloc>()
                                                        .selectedDate),
                                                'day': DateFormat('dd').format(
                                                    context
                                                        .read<HomeBloc>()
                                                        .selectedDate),
                                              })),
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    scrollDirection: Axis.horizontal,
                                    child: Builder(
                                      builder: (context) {
                                        final matches =
                                            context.read<HomeBloc>().matches;
                                        if (matches.isEmpty) {
                                          return Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 30),
                                              child: Stack(
                                                children: [
                                                  Text(
                                                    "오늘\n매치가 없습니다",
                                                    style: TextStyle(
                                                      fontFamily: 'GmarketSans',
                                                      fontSize: 48,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1
                                                        ..color =
                                                            GogoColors.main600,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Transform.translate(
                                                    offset: Offset(5, -3),
                                                    child: Text(
                                                      "오늘\n매치가 없습니다",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'GmarketSans',
                                                        fontSize: 48,
                                                        color:
                                                            GogoColors.main600,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Row(
                                            children: List.generate(
                                              min(matches.length, 5),
                                              (index) {
                                                final match = matches[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: MatchCard(
                                                    matchDto: match,
                                                    onBattingClick: () {},
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                spacing: 16,
                                children: [
                                  _itemTopBar(
                                      GogoIcons.arcade(color: GogoColors.white),
                                      text: '미니게임',
                                      onTap: () => PageRouter.router.pushNamed(
                                          PageRouter.miniGame, 
                                          queryParameters: {
                                            'stageId': stageId.toString(),
                                            'point': state.points.point.toString(),
                                          })),
                                  MinigamePlayComponent(
                                    activeGameResponse:
                                        state.activeGameResponse,
                                    stageId: stageId!,
                                  )
                                ],
                              ),
                              Column(
                                spacing: 16,
                                children: [
                                  _itemTopBar(
                                      GogoIcons.trophy(color: GogoColors.white),
                                      text: '포인트 랭킹',
                                      onTap: () => PageRouter.gogoPushNamed(
                                          PageRouter.ranking, stageId!)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      spacing: 8,
                                      children: List.generate(
                                        min(state.ranking.length, 5),
                                        (index) {
                                          final rank = state.ranking[index];
                                          return RankingListItem(
                                            index: index,
                                            name: rank.name,
                                            point: rank.point,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                spacing: 16,
                                children: [
                                  _itemTopBar(
                                      GogoIcons.community(
                                          color: GogoColors.white),
                                      text: '커뮤니티',
                                      onTap: () => PageRouter.gogoPushNamed(
                                          PageRouter.community, stageId!)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      spacing: 8,
                                      children: List.generate(
                                        min(state.communityPosts.length, 5),
                                        (index) {
                                          final board =
                                              state.communityPosts[index];
                                          return CommunityItem(
                                            name: '역명',
                                            gameType: board.gameCategory,
                                            title: board.title,
                                            commentNum: board.commentCount,
                                            likeNum: board.likeCount,
                                            ontap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommunityDetailScreen(
                                                          boardId: state
                                                              .communityPosts[
                                                                  index]
                                                              .boardId),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                spacing: 16,
                                children: [
                                  _itemTopBar(
                                      GogoIcons.trophy(color: GogoColors.white),
                                      text: '경기',
                                      onTap: () => PageRouter.gogoPushNamed(
                                          PageRouter.matchTeamInfo, stageId!)),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      spacing: 8,
                                      children: List.generate(
                                        min(state.gameResponse.count, 5),
                                        (index) => MatchGameItem(
                                          gameItem:
                                              state.gameResponse.games[index],
                                          onTap: () =>
                                              PageRouter.router.pushNamed(
                                            PageRouter.matchTeamInfo,
                                            queryParameters: {
                                              'stageId': stageId.toString(),
                                              'gameIndex': index.toString()
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
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

  Widget _itemTopBar(
    Widget gogoIcon, {
    String? text,
    DateTime? date,
    VoidCallback? onTap,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
}
