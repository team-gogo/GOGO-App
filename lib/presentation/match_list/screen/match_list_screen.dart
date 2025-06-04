import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/presentation/loading/widgets/loading_indicator.dart';
import '../../../data/models/betting/request/betting_match_request.dart';
import '../../home/widgets/match_batting_status_dialog.dart';
import '../../home/widgets/match_card/match_card_component.dart';
import '../bloc/match_list_bloc.dart';
import '../bloc/match_list_event.dart';
import '../bloc/match_list_state.dart';

class MatchListScreen extends StatelessWidget {
  final int stageId;
  final int point;
  final int year;
  final int month;
  final int day;

  const MatchListScreen(
      {super.key,
      required this.stageId,
      required this.point,
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
                        return const Center(child: LoadingIndicator());
                      } else if (state is LoadedMatchList) {
                        if (state.matchList.isEmpty) {
                          return Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Text(
                                  "오늘\n매치가 없습니다",
                                  style: TextStyle(
                                    fontFamily: 'GmarketSans',
                                    fontSize: 48,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1
                                      ..color = GogoColors.main600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Transform.translate(
                                  offset: Offset(5, -3),
                                  child: Text(
                                    "오늘\n매치가 없습니다",
                                    style: TextStyle(
                                      fontFamily: 'GmarketSans',
                                      fontSize: 48,
                                      color: GogoColors.main600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: state.matchList.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final matchDto = state.matchList[index];
                            return MatchCard(
                              matchDto: matchDto,
                              width: double.infinity,
                              onBattingClick: () {
                                showDialogMatchBatting(
                                    context, matchDto, point);
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
    int point,
  ) {
    final matchListBloc =
        MatchListBloc(stageId: stageId, year: year, month: month, day: day);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final textController = TextEditingController();
        int aTeamPoint = data.ateam.bettingPoint;
        int bTeamPoint = data.bteam.bettingPoint;
        String? selectedTeam;

        return StatefulBuilder(
          builder: (context, setState) {
            return MatchBattingStatusDialog(
              bettingController: textController,
              startDate: data.startDate,
              system: data.system,
              gameType: data.category,
              round: data.round,
              selectedTeam: selectedTeam,
              setSelectedTeam: (team) {
                setState(() {
                  selectedTeam = team;
                });
              },
              teamAPoint: aTeamPoint,
              teamBPoint: bTeamPoint,
              teamA: data.ateam.teamName,
              teamB: data.bteam.teamName,
              enableBetting:
                  !data.isEnd && data.startDate.isBefore(DateTime.now()),
              closeDialog: () {
                Navigator.pop(dialogContext);
              },
              onBattingClick: () {
                final inputText = textController.text.trim();
                final bettingPoint = int.tryParse(inputText);

                // === 유효성 검사 ===
                if (selectedTeam == null) {
                  _showError(dialogContext, '배팅할 팀을 선택해주세요.');
                  return;
                }

                if (bettingPoint == null) {
                  _showError(dialogContext, '배팅할 포인트를 입력해주세요.');
                  return;
                }

                if (bettingPoint < 1000) {
                  _showError(dialogContext, '배팅 포인트는 최소 1000 이상이어야 합니다.');
                  return;
                }

                if (bettingPoint > 5000) {
                  _showError(dialogContext, '배팅 포인트는 최대 5000 이하로 입력해주세요.');
                  return;
                }

                if (bettingPoint > point) {
                  _showError(dialogContext, '보유 포인트를 초과할 수 없습니다.');
                  return;
                }

                final predictedTeamId = (selectedTeam == data.ateam.teamName)
                    ? data.ateam.teamId
                    : data.bteam.teamId;

                if (predictedTeamId == null) {
                  _showError(dialogContext, '선택한 팀의 ID를 찾을 수 없습니다.');
                  return;
                }

                setState(() {
                  if (selectedTeam == data.ateam.teamName) {
                    aTeamPoint += bettingPoint;
                  } else {
                    bTeamPoint += bettingPoint;
                  }
                });

                final request = BettingMatchRequest(
                  predictedWinTeamId: predictedTeamId,
                  bettingPoint: bettingPoint,
                );

                matchListBloc.add(
                  BettingMatch(
                    matchId: data.matchId,
                    request: request,
                  ),
                );

                matchListBloc.add(LoadItems(
                  gameType: data.category,
                  sortOrder: SortOrder.ascending,
                ));

                Navigator.pop(dialogContext); // 성공 후 다이얼로그 닫기
              },
            );
          },
        );
      },
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
