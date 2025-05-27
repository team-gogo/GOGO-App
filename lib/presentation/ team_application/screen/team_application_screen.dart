  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:gogo_app/data/models/stage/create_stage/game.dart';
  import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_game_response.dart';
  import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
  import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
  import 'package:gogo_app/design_system/theme/color.dart';
  import 'package:gogo_app/design_system/theme/icon.dart';
  import 'package:gogo_app/design_system/theme/typography.dart';
  import 'package:gogo_app/presentation/%20team_application/bloc/game_bloc.dart';
  import 'package:gogo_app/presentation/%20team_application/bloc/game_event.dart';
  import 'package:gogo_app/presentation/%20team_application/widget/game_widget.dart';

  import '../../loading/screens/loadaing_page.dart';
  import '../bloc/game_state.dart';

  class TeamApplicationScreen extends StatelessWidget {
    final int stageId;
    final bool isManger;

    TeamApplicationScreen(
        {super.key, required this.stageId, required this.isManger});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (context) => GameBloc()..add(GetGameEvent(stageId: stageId)),
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                if (state is GameLoading || state is GameInitial) {
                  return LoadingPage();
                }

                // Game 목록과 개수를 상태에서 가져오기
                List<SearchGameItem> matches = [];
                int count = 0;
                if (state is GameLoaded) {
                  matches = state.gameItem.games;
                  count = matches.length;
                } else if (state is GameError) {
                  return Center(child: Text('에러 발생: ${state.message}'));
                }
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0.w, vertical: 8.0.h),
                      child: GogoTopBar(title: '돌아가기', onBackTap: () {}),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '스테이지 이름 경기들',
                                  style: GogoTypography.caption1Extrabold
                                      .copyWith(color: GogoColors.white),
                                ),
                                Row(
                                  spacing: 12.w,
                                  children: [
                                    GogoTagComponent(
                                      color: GogoColors.gray400,
                                      text: '확정하기',
                                      icon: GogoIcons.check(
                                        color: GogoColors.gray400,
                                      ),
                                    ),
                                    GogoTagComponent(
                                      color: GogoColors.main500,
                                      text: '필터',
                                      icon: GogoIcons.filter(
                                        color: GogoColors.main500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 24.h),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  spacing: 16.h,
                                  children:
                                      List.generate(matches.length, (index) {
                                    final SearchGameItem game = matches[index];
                                    return GameWidget(
                                      game: game,
                                      isManger: isManger,
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
    }
  }
