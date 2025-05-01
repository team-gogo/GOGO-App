import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/data/models/stage/community/community_search_request_query_string.dart';
import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/bloc/main/community_bloc.dart';
import 'package:gogo_app/presentation/community/bloc/main/community_event.dart';
import 'package:gogo_app/presentation/community/bloc/main/community_state.dart';
import 'package:gogo_app/presentation/community/screen/community_detail_screen.dart';
import 'package:gogo_app/presentation/community/widgets/community_filter_popup.dart';
import 'package:gogo_app/presentation/community/widgets/community_item.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import '../../../design_system/component/tag/gogo_tag_component.dart';
import '../../../design_system/component/top_bar/gogo_top_bar.dart';
import '../../../design_system/theme/icon.dart';
import '../../../router.dart';

class CommunityMainScreen extends StatelessWidget {
  final int stageId;

  const CommunityMainScreen({super.key, required this.stageId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommunityBloc>(
      create: (BuildContext context) => CommunityBloc(
        stageId: stageId,
      ),
      child: CommunityMainScreenContent(stageId: stageId),
    );
  }
}

class CommunityMainScreenContent extends StatefulWidget {
  final int stageId;

  const CommunityMainScreenContent({super.key, required this.stageId});

  @override
  State<CommunityMainScreenContent> createState() =>
      _CommunityMainScreenContentState();
}

class _CommunityMainScreenContentState
    extends State<CommunityMainScreenContent> {
  final ScrollController scrollController = ScrollController();
  int currentPage = 0;
  final int resultPerPage = 15;
  GameType? gameType;
  SortType? sortType = SortType.LATEST;

  @override
  void initState() {
    super.initState();
    _fetchCommunity();
  }

  void _fetchCommunity() {
    context.read<CommunityBloc>().add(
          FetchCommunityEvent(
            queryString: CommunitySearchRequestQueryString(
              page: currentPage,
              size: resultPerPage,
              type: gameType,
              sort: sortType,
            ),
          ),
        );
  }

  void _onPageChanged(int newPage) {
    setState(() {
      currentPage = newPage;
    });
    scrollController.jumpTo(0);
    _fetchCommunity();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            children: [
              GogoTopBar(title: '뒤로가기', onBackTap: () => context.pop()),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GogoIcons.community(color: GogoColors.white),
                      const SizedBox(width: 12),
                      Text(
                        '커뮤니티',
                        style: GogoTypography.body2Extrabold
                            .copyWith(color: GogoColors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async{
                          final result = await context.pushNamed(PageRouter.communityWrite);
                          if (result == true) {
                            _fetchCommunity(); 
                          }
                        },
                        child: GogoTagComponent(
                          color: GogoColors.white,
                          text: '글 쓰기',
                          icon: GogoIcons.plusCircle(color: GogoColors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () async {
                          final result =
                              await filterDialog(context, gameType, sortType);
                          if (gameType == result['gameType'] &&
                              sortType == result['sortType']) {
                            return;
                          }
                          gameType = result['gameType'];
                          sortType = result['sortType'];
                          _fetchCommunity();
                        },
                        child: GogoTagComponent(
                          color: GogoColors.main500,
                          text: '필터',
                          icon: GogoIcons.filter(color: GogoColors.main500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '운동 종류',
                        style: GogoTypography.caption3Semibold
                            .copyWith(color: GogoColors.gray600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '제목',
                        style: GogoTypography.caption3Semibold
                            .copyWith(color: GogoColors.gray600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '이름',
                        style: GogoTypography.caption3Semibold
                            .copyWith(color: GogoColors.gray600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '좋아요 & 댓글',
                        style: GogoTypography.caption3Semibold
                            .copyWith(color: GogoColors.gray600),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(color: GogoColors.gray600, thickness: 0, height: 1),
              BlocBuilder<CommunityBloc, CommunityState>(
                builder: (context, state) {
                  if (state is CommunityLoadingState) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                            color: GogoColors.main600),
                      ),
                    );
                  } else if (state is CommunityLoadedState) {
                    final totalPage = state.response.info.totalPage;
                    final startPage = (currentPage / 5).floor() * 5;
                    final endPage = min(startPage + 5, totalPage);

                    return Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Column(
                              spacing: 8,
                              children: List.generate(
                                state.response.board.length,
                                (index) => CommunityItem(
                                  gameType:
                                      state.response.board[index].gameCategory,
                                  title: state.response.board[index].title,
                                  name: "익명",
                                  commentNum: state.response.board[index].commentCount,
                                  likeNum:
                                      state.response.board[index].likeCount,
                                  ontap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityDetailScreen(boardId: state.response.board[index].boardId)));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                currentPage > 0
                                    ? InkWell(
                                        onTap: () =>
                                            _onPageChanged(currentPage - 1),
                                        child: GogoIcons.chevronLeft(
                                          color: GogoColors.gray500,
                                          width: 16,
                                          height: 16,
                                        ),
                                      )
                                    : const SizedBox(width: 16),
                                for (int i = startPage; i < endPage; i++)
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      minimumSize: const Size(16, 16),
                                    ),
                                    onPressed: () => _onPageChanged(i),
                                    child: Text(
                                      (i + 1).toString(),
                                      style: GogoTypography.caption1Extrabold
                                          .copyWith(
                                        color: currentPage == i
                                            ? GogoColors.main600
                                            : GogoColors.gray500,
                                      ),
                                    ),
                                  ),
                                currentPage < totalPage - 1
                                    ? InkWell(
                                        onTap: () =>
                                            _onPageChanged(currentPage + 1),
                                        child: GogoIcons.chevronRight(
                                          color: GogoColors.gray500,
                                          width: 16,
                                          height: 16,
                                        ),
                                      )
                                    : const SizedBox(width: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is CommunityErrorState) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'Error: ${state.message}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Text('No data available',
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
