import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import '../../home/widgets/match_batting_status_dialog.dart';
import '../../home/widgets/match_card/match_card_component.dart';
import '../bloc/match_list_bloc.dart';
import '../bloc/match_list_event.dart';
import '../bloc/match_list_state.dart';

class MatchListScreen extends StatelessWidget {
  final int stageId;
  final int year;
  final int month;
  final int day;

  const MatchListScreen(
      {super.key,
      required this.stageId,
      required this.year,
      required this.month,
      required this.day});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MatchListBloc>(
      create: (_) => MatchListBloc(
        stageId: stageId,
        year: year,
        month: month,
        day: day,
      )..add(LoadItems(
          gameType: null,
          sortOrder: SortOrder.descending,
        )),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              children: [
                GogoTopBar(title: "매치 목록", onBackTap: () => context.pop()),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GogoTagComponent(
                        color: GogoColors.main500,
                        text: "필터",
                        icon: GogoIcons.filter(
                          color: GogoColors.main500,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: BlocBuilder<MatchListBloc, MatchListState>(
                    builder: (context, state) {
                      if (state is LoadingMatchList) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is LoadedMatchList) {
                        if (state.matchList.isEmpty) {
                          return const Center(child: Text("매치가 없습니다"));
                        }
                        return ListView.separated(
                          itemCount: state.matchList.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final matchDto = state.matchList[index];
                            return MatchCard(
                              matchDto: matchDto,
                              width: double.infinity,
                              onBattingClick: () {
                                showDialogMatchBatting(context, matchDto);
                              },
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogMatchBatting(
    BuildContext context,
    MatchDto data,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MatchBattingStatusDialog(
          startDate: data.startDate,
          system: data.system,
          gameType: data.category,
          round: data.round,
          teamAPoint: data.ateam.bettingPoint,
          teamBPoint: data.bteam.bettingPoint,
          teamA: data.ateam.teamName,
          teamB: data.bteam.teamName,
          enableBetting: !data.isEnd && data.startDate.isBefore(DateTime.now()),
          closeDialog: () {
            Navigator.pop(context);
          },
          onBattingClick: (String team) {},
        );
      },
    );
  }
}
