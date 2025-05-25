import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/loading/screens/loadaing_page.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_state.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_bloc.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_event.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_state.dart';
import 'package:gogo_app/presentation/ranking/widgets/ranking_component.dart';
import 'package:gogo_app/presentation/ranking/widgets/ranking_list_item.dart';

import '../../../design_system/component/indicator/refresh_indicator.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key, required this.stageId});

  final int stageId;

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final ScrollController _scrollController = ScrollController();
  final RankingBloc _rankingBloc = RankingBloc();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _rankingBloc.add(
        GetRanking(stageId: widget.stageId),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          _rankingBloc..add(GetRanking(stageId: widget.stageId)),
      child: BlocBuilder<RankingBloc, RankingState>(builder: (context, state) {
        final rank = _rankingBloc.rank;
        if (state is LoadedRanking) {
          return Scaffold(
            backgroundColor: GogoColors.black,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GogoRefreshIndicator(
                  onRefresh: () async => _rankingBloc.add(
                    GetRanking(stageId: widget.stageId, isRefresh: true),
                  ),
                  child: Column(
                    spacing: 24,
                    children: [
                      GogoTopBar(
                          title: '포인트 랭킹',
                          onBackTap: () => context.pop(context)),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 256,
                        decoration: BoxDecoration(
                          color: GogoColors.gray700,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOP 3',
                              style: GogoTypography.body2Extrabold
                                  .copyWith(color: Colors.white),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RankingComponent(
                                  points: rank[1].point,
                                  name: rank[1].name,
                                  colors: [
                                    Color(0xFF989898),
                                    Color(0xFFD5D5D5),
                                    Color(0xFF676767),
                                  ],
                                  circleSize: 70,
                                  iconSize: 24,
                                ),
                                RankingComponent(
                                  points: rank[0].point,
                                  name: rank[0].name,
                                  colors: [
                                    Color(0xFFA07102),
                                    Color(0xFFFADC73),
                                    Color(0xFF9F812E),
                                  ],
                                  circleSize: 90,
                                  iconSize: 40,
                                ),
                                RankingComponent(
                                  points: rank[2].point,
                                  name: rank[2].name,
                                  colors: [
                                    Color(0xFFAE5C43),
                                    Color(0xFFF4A98C),
                                    Color(0xFF763920),
                                  ],
                                  circleSize: 70,
                                  iconSize: 24,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            spacing: 8,
                            children: List.generate(
                              rank.length - 3,
                              (index) => RankingListItem(
                                  index: index+3,
                                  name: rank[index + 3].name,
                                  point: rank[index + 3].point),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is InitRanking) {
          return LoadingPage();
        } else {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GogoRefreshIndicator(
                  onRefresh: () async => _rankingBloc.add(
                    GetRanking(stageId: widget.stageId, isRefresh: true),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '랭킹을 불러오지 못했습니다.',
                        style: GogoTypography.body2Extrabold
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '다시 시도해주세요.',
                        style: GogoTypography.body2Extrabold
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
