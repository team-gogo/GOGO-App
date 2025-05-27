import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/loading/screens/loadaing_page.dart';
import 'package:gogo_app/presentation/match_detail/widget/match_participant_widget.dart';
import 'package:gogo_app/presentation/match_detail/widget/match_point_widget.dart';
import 'package:gogo_app/presentation/match_detail/widget/match_state_widget.dart';

import '../../../data/models/common/team_response.dart';
import '../../../data/models/stage/search_stage/search_match_info_response.dart';
import '../../../design_system/component/top_bar/gogo_top_bar.dart';
import '../bloc/match_info_bloc.dart';
import '../bloc/match_info_event.dart';
import '../bloc/match_info_state.dart';
import '../bloc/widget/page_indicator_bloc.dart';
import '../bloc/widget/page_indicator_event.dart';
import '../bloc/widget/page_indicator_state.dart';

class MatchDetailScreen extends StatelessWidget {
  final MatchDto matchDto;
  final int matchId;

  MatchDetailScreen({super.key, required this.matchDto, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final double originalWidth = 1200;
    final double originalHeight = 448;

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => SearchMatchBloc(stageId: matchId)
              ..add(SearchMatchRequested(matchId: matchId)),
          ),
          BlocProvider<PageIndicatorBloc>(
            create: (context) => PageIndicatorBloc(),
          ),
        ],
        child: BlocBuilder<SearchMatchBloc, SearchMatchState>(
          builder: (context, state) {
            if (state is SearchMatchLoading) {
              return const LoadingPage();
            } else if (state is SearchMatchSuccess) {
              final matchInfo = state.matchInfo;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 28.h,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GogoTopBar(
                          title:
                              '${matchInfo.ateam.teamName} vs ${matchInfo.bteam.teamName}',
                          onBackTap: () => context.pop(),
                        ),
                      ),
                      MatchStateWidget(matchDto: matchDto),
                      MatchPointWidget(matchDto: matchDto),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '팀 정보',
                                  style: GogoTypography.body2Extrabold
                                      .copyWith(color: GogoColors.white),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 24.sp,
                                          height: 24.sp,
                                          decoration: BoxDecoration(
                                            color: GogoColors.teamBlue,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          '${matchInfo.ateam.teamName}팀',
                                          style: GogoTypography.body3Extrabold
                                              .copyWith(color: GogoColors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 24.w),
                                    Row(
                                      children: [
                                        Container(
                                          width: 24.sp,
                                          height: 24.sp,
                                          decoration: BoxDecoration(
                                            color: GogoColors.teamRed,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          '${matchInfo.bteam.teamName}팀',
                                          style: GogoTypography.body3Extrabold
                                              .copyWith(color: GogoColors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: originalWidth,
                            height: originalHeight,
                            child: BlocBuilder<PageIndicatorBloc,
                                PageIndicatorState>(
                              builder: (context, pageState) {
                                final List<Participant> aTeamParticipant =
                                    matchInfo.ateam.participants;
                                final List<Participant> bTeamParticipant =
                                    matchInfo.bteam.participants;
                                return PageView(
                                  onPageChanged: (index) {
                                    context
                                        .read<PageIndicatorBloc>()
                                        .add(PageChangedEvent(index));
                                  },
                                  controller: PageController(
                                      initialPage: pageState.currentIndex),
                                  children: [
                                    Stack(
                                      children: [
                                        _halfImage(context, matchInfo,
                                            isLeft: true),
                                        ...aTeamParticipant.map((p) {
                                          final double x =
                                              (double.tryParse(p.positionX) ?? 0);
                                          final double y =
                                              (double.tryParse(p.positionY) ?? 0);
                                          final xRatio = x / originalWidth;
                                          final yRatio = y / originalHeight;
                                          return MatchParticipantWidget(
                                              x: xRatio * originalWidth,
                                              y: yRatio * originalHeight,
                                              redOrBlue: TeamColor.blue,
                                              name: p.name);
                                        }),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        _halfImage(context, matchInfo,
                                            isLeft: false),
                                        ...bTeamParticipant.map((p) {
                                          final double x =
                                              (double.tryParse(p.positionX) ?? 0);
                                          final double y =
                                              (double.tryParse(p.positionY) ?? 0);
                                          final xRatio = x / originalWidth;
                                          final yRatio = y / originalHeight;
                                          return MatchParticipantWidget(
                                              x: xRatio * originalWidth,
                                              y: yRatio * originalHeight,
                                              redOrBlue: TeamColor.red,
                                              name: p.name);
                                        }),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<PageIndicatorBloc, PageIndicatorState>(
                        builder: (context, pageState) {
                          final isLeft = pageState.currentIndex == 0;
                          final Color activeColor =
                              isLeft ? GogoColors.teamBlue : GogoColors.teamRed;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 8,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: GogoColors.gray700,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                AnimatedAlign(
                                  alignment: isLeft
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: activeColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is SearchMatchFailure) {
              return Center(child: Text('에러: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  static Widget _halfImage(
      BuildContext context, SearchMatchInfoResponse matchInfo,
      {required bool isLeft}) {
    final image = switch (matchInfo.category) {
      GameType.SOCCER => isLeft
          ? GogoIcons.footballMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.footballMap(),
            ),
      GameType.BASKET_BALL => isLeft
          ? GogoIcons.basketballMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.basketballMap(),
            ),
      GameType.BASE_BALL => isLeft
          ? GogoIcons.baseballMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.baseballMap(),
            ),
      GameType.VOLLEY_BALL => isLeft
          ? GogoIcons.volleyballMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.volleyballMap(),
            ),
      GameType.BADMINTON => isLeft
          ? GogoIcons.badmintonMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.badmintonMap(),
            ),
      GameType.LOL => Container(color: GogoColors.gray600), //TODO: 스테이지 삽입 요망
      GameType.ETC => Container(color: GogoColors.gray600), //TODO: 스테이지 삽입 요망
    };
    return image;
  }
}
