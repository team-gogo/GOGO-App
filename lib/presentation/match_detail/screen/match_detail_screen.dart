import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/match_round.dart';
import 'package:gogo_app/data/models/stage/enum_type/system_type.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_betting_stage_response.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/match_detail/widget/match_point_widget.dart';
import 'package:gogo_app/presentation/match_detail/widget/match_state_widget.dart';

import '../../../design_system/component/top_bar/gogo_top_bar.dart';
import '../bloc/page_indicator_bloc.dart';
import '../bloc/page_indicator_event.dart';
import '../bloc/page_indicator_state.dart';

class MatchDetailScreen extends StatelessWidget {
  MatchDetailScreen({super.key});

  final PageController _pageController = PageController();

  final MatchDto matchDto = MatchDto(
    matchId: 1,
    aTeam: MatchTeam(teamId: 1, teamName: 'A', bettingPoint: 5000, winCount: 1),
    bTeam: MatchTeam(teamId: 2, teamName: 'B', bettingPoint: 5000, winCount: 0),
    startDate: DateTime(1),
    endDate: DateTime(2),
    isEnd: false,
    category: GameType.SOCCER,
    gameName: 'A팀 vs B팀',
    system: System.TOURNAMENT,
    isNotice: true,
    betting: Betting(isBetting: true, predictedWinTeamId: 1, bettingPoint: 500),
    round: MatchRound.FINALS,
  );

  @override
  Widget build(BuildContext context) {
    Widget halfImage({required bool isLeft}) {
      final image = switch (matchDto.category) {
        GameType.SOCCER => GogoIcons.footballFullMap(),
        GameType.BASKET_BALL => GogoIcons.basketballFullMap(),
        GameType.BASE_BALL => GogoIcons.baseballFullMap(),
        GameType.VOLLEY_BALL => Container(color: GogoColors.gray600),
        GameType.BADMINTON => GogoIcons.badmintonFullMap(),
        GameType.LOL => Container(color: GogoColors.gray600),
        GameType.ETC => Container(color: GogoColors.gray600),
      };

      final fullWidth = MediaQuery.of(context).size.width * 2;
      final fullHeight = fullWidth / (1320 / 464);

      return SizedBox(
        height: fullHeight,
        width: MediaQuery.of(context).size.width,
        child: OverflowBox(
          maxWidth: fullWidth,
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: SizedBox(
            width: fullWidth,
            height: fullHeight,
            child: image, // FittedBox 제거
          ),
        ),
      );
    }

    return BlocProvider(
      create: (_) => PageIndicatorBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              spacing: 42.h,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GogoTopBar(
                    title: 'A팀 vs B팀',
                    onBackTap: () => context.pop(context),
                  ),
                ),
                Column(
                  spacing: 20.h,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MatchStateWidget(matchDto: matchDto),
                    MatchPointWidget(matchDto: matchDto),
                  ],
                ),
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
                            spacing: 24.w,
                            children: [
                              Row(
                                spacing: 8.w,
                                children: [
                                  Container(
                                    width: 24.sp,
                                    height: 24.sp,
                                    decoration: BoxDecoration(
                                      color: GogoColors.teamBlue,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  Text(
                                    '${matchDto.aTeam.teamName}팀',
                                    style: GogoTypography.body3Extrabold
                                        .copyWith(color: GogoColors.white),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 8.w,
                                children: [
                                  Container(
                                    width: 24.sp,
                                    height: 24.sp,
                                    decoration: BoxDecoration(
                                      color: GogoColors.teamRed,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  Text(
                                    '${matchDto.bTeam.teamName}팀',
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
                      height: (MediaQuery.of(context).size.width * 2) /
                          (1320 / 464),
                      width: double.infinity,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          context
                              .read<PageIndicatorBloc>()
                              .add(PageChangedEvent(index));
                        },
                        children: [
                          halfImage(isLeft: true), // 왼쪽 절반
                          halfImage(isLeft: false), // 오른쪽 절반
                        ],
                      ),
                    )
                  ],
                ),
                BlocBuilder<PageIndicatorBloc, PageIndicatorState>(
                  builder: (context, state) {
                    final isLeft = state.currentIndex == 0;
                    final Color activeColor =
                        isLeft ? GogoColors.teamBlue : GogoColors.teamRed;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Stack(
                        children: [
                          // 회색 배경 바
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
                              widthFactor: 0.5, // 절반 너비
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
      }),
    );
  }
}
