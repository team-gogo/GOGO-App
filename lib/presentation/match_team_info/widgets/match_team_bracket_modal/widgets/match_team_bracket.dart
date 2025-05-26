import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/data/models/stage/enum_type/match_round.dart';
import 'package:gogo_app/data/models/stage/search_information/search_game_format_response.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_bracket_modal/bloc/match_team_bracket_bloc.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_bracket_modal/bloc/match_team_bracket_event.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_bracket_modal/bloc/match_team_bracket_state.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_bracket_modal/widgets/match_team_bracket_line.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_bracket_modal/widgets/match_team_bracket_player.dart';

import '../../../../../design_system/theme/color.dart';
import '../../../../loading/widgets/loading_indicator.dart';

class MatchTeamBracket extends StatelessWidget {
  MatchTeamBracket({super.key, required this.gameId});

  final int gameId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          MatchTeamBracketBloc()..add(GetMatchTeamBracket(gameId: gameId)),
      child: BlocBuilder<MatchTeamBracketBloc, MatchTeamBracketState>(
          builder: (context, state) {
        if (state is InitMatchTeamBracket || state is LoadingMatchTeamBracket) {
          return Container(
              height: 400,
              alignment: Alignment.center,
              child: LoadingIndicator());
        } else if (state is LoadedMatchTeamBracket) {
          switch (state.gameFormatResponse.format[0].round) {
            case MatchRound.ROUND_OF_32:
              return Container(
                height: 400,
                alignment: Alignment.center,
                child: Text(
                  '32강 대진표는 준비중입니다.',
                  style: GogoTypography.body2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
              );
            case MatchRound.ROUND_OF_16:
              return _round16Finals(state.gameFormatResponse);
            case MatchRound.QUARTER_FINALS:
              return _quarterFinals(state.gameFormatResponse);
            case MatchRound.SEMI_FINALS:
              return _semiFinals(state.gameFormatResponse);
            case MatchRound.FINALS:
              return _finals(state.gameFormatResponse);
          }
        } else {
          return Container(
            height: 400,
            alignment: Alignment.center,
            child: Text(
              '대진표를 불러오지 못했습니다.',
              style: GogoTypography.body2Extrabold
                  .copyWith(color: GogoColors.white),
            ),
          );
        }
      }),
    );
  }

  Widget _finals(SearchGameFormatResponse gameFormatResponse) {
    final TournamentMatch typedefMatch = TournamentMatch(
        matchId: 0,
        turn: 0,
        aTeamName: 'TBD',
        bTeamName: 'TBD',
        isEnd: false,
        winTeamId: -1);

    final List<TournamentMatch> finalMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.FINALS)
        .match;
    TournamentMatch finalTurn1 =
        finalMatches.firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);

    return SizedBox(
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MatchTeamBracketPlayer(
            teamName: finalTurn1.aTeamName,
            isWin: finalTurn1.winTeamId == finalTurn1.aTeamId,
          ),
          Container(
            decoration: BoxDecoration(color: GogoColors.gray600),
            width: 60,
            height: 4,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(height: 100),
              Positioned(
                top: 0,
                child: Text(
                  '결승',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
              ),
              MatchTeamBracketPlayer(
                teamName: () {
                  if (finalTurn1.winTeamId == null) return 'TBD';
                  if (finalTurn1.aTeamId == finalTurn1.winTeamId)
                    return finalTurn1.aTeamName;
                  if (finalTurn1.bTeamId == finalTurn1.winTeamId)
                    return finalTurn1.bTeamName;
                  return 'TBD';
                }(),
                isWin: finalTurn1.isEnd,
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: GogoColors.gray600),
            width: 60,
            height: 4,
          ),
          MatchTeamBracketPlayer(
            teamName: finalTurn1.bTeamName,
            isWin: finalTurn1.winTeamId == finalTurn1.bTeamId,
          ),
        ],
      ),
    );
  }

  Widget _semiFinals(SearchGameFormatResponse gameFormatResponse) {
    final TournamentMatch typedefMatch = TournamentMatch(
        matchId: 0,
        turn: 0,
        aTeamName: 'TBD',
        bTeamName: 'TBD',
        isEnd: false,
        winTeamId: -1);

    final List<TournamentMatch> semiMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.SEMI_FINALS)
        .match;
    TournamentMatch semiTurn1 =
        semiMatches.firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);
    TournamentMatch semiTurn2 =
        semiMatches.firstWhere((m) => m.turn == 2, orElse: () => typedefMatch);

    final List<TournamentMatch> finalMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.FINALS)
        .match;
    TournamentMatch finalTurn1 =
        finalMatches.firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);

    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(width: 250),
                  Positioned(
                      right: 50,
                      child: MatchTeamBracketLine(isLeft: true, height: 200)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MatchTeamBracketPlayer(
                          teamName: semiTurn1.aTeamName,
                          isWin: semiTurn1.winTeamId == semiTurn1.aTeamId),
                      MatchTeamBracketPlayer(
                          teamName: semiTurn1.bTeamName,
                          isWin: semiTurn1.winTeamId == semiTurn1.bTeamId),
                    ],
                  ),
                  Positioned(
                      right: 0,
                      child: MatchTeamBracketPlayer(
                        teamName: finalTurn1.aTeamName,
                        isWin: finalTurn1.winTeamId == finalTurn1.aTeamId,
                      )),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: GogoColors.gray600),
                width: 60,
                height: 4,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(height: 100),
                  Positioned(
                    top: 0,
                    child: Text(
                      '결승',
                      style: GogoTypography.caption2Extrabold
                          .copyWith(color: GogoColors.white),
                    ),
                  ),
                  MatchTeamBracketPlayer(
                    teamName: () {
                      if (finalTurn1.winTeamId == null) return 'TBD';
                      if (finalTurn1.aTeamId == finalTurn1.winTeamId)
                        return finalTurn1.aTeamName;
                      if (finalTurn1.bTeamId == finalTurn1.winTeamId)
                        return finalTurn1.bTeamName;
                      return 'TBD';
                    }(),
                    isWin: finalTurn1.isEnd,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: GogoColors.gray600),
                width: 60,
                height: 4,
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  SizedBox(width: 250),
                  Positioned(
                      left: 50,
                      child: MatchTeamBracketLine(isLeft: false, height: 200)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MatchTeamBracketPlayer(
                          teamName: semiTurn2.aTeamName,
                          isWin: semiTurn2.winTeamId == semiTurn2.aTeamId),
                      MatchTeamBracketPlayer(
                          teamName: semiTurn2.bTeamName,
                          isWin: semiTurn2.winTeamId == semiTurn2.bTeamId),
                    ],
                  ),
                  Positioned(
                      left: 0,
                      child: MatchTeamBracketPlayer(
                        teamName: finalTurn1.bTeamName,
                        isWin: finalTurn1.winTeamId == finalTurn1.bTeamId,
                      )),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 750,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('4강',
                    style: GogoTypography.caption2Extrabold
                        .copyWith(color: GogoColors.white)),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                Text('4강',
                    style: GogoTypography.caption2Extrabold
                        .copyWith(color: GogoColors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quarterFinals(SearchGameFormatResponse gameFormatResponse) {
    final TournamentMatch typedefMatch = TournamentMatch(
        matchId: 0,
        turn: 0,
        aTeamName: 'TBD',
        bTeamName: 'TBD',
        isEnd: false,
        winTeamId: -1);
    final List<TournamentMatch> quarterMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.QUARTER_FINALS)
        .match;
    TournamentMatch? quarterTurn1 = quarterMatches
        .firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);
    TournamentMatch? quarterTurn2 = quarterMatches
        .firstWhere((m) => m.turn == 2, orElse: () => typedefMatch);
    TournamentMatch? quarterTurn3 = quarterMatches
        .firstWhere((m) => m.turn == 3, orElse: () => typedefMatch);
    TournamentMatch? quarterTurn4 = quarterMatches
        .firstWhere((m) => m.turn == 4, orElse: () => typedefMatch);

    final List<TournamentMatch> semiMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.SEMI_FINALS)
        .match;
    TournamentMatch? semiTurn1 =
        semiMatches.firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);
    TournamentMatch? semiTurn2 =
        semiMatches.firstWhere((m) => m.turn == 2, orElse: () => typedefMatch);

    final List<TournamentMatch> finalMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.FINALS)
        .match;
    TournamentMatch? finalTurn1 =
        finalMatches.firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MatchTeamBracketPlayer(
                    teamName: quarterTurn1.aTeamName,
                    isWin: quarterTurn1.winTeamId == quarterTurn1.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: quarterTurn1.bTeamName,
                    isWin: quarterTurn1.winTeamId == quarterTurn1.bTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: quarterTurn2.aTeamName,
                    isWin: quarterTurn2.winTeamId == quarterTurn2.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: quarterTurn2.bTeamName,
                    isWin: quarterTurn2.winTeamId == quarterTurn2.bTeamId,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(
                    width: 300,
                  ),
                  Positioned(
                      right: 50,
                      child: MatchTeamBracketLine(isLeft: true, height: 200)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          SizedBox(width: 200),
                          MatchTeamBracketLine(isLeft: true, height: 100),
                          Positioned(
                              left: 50,
                              child: MatchTeamBracketPlayer(
                                teamName: semiTurn1.aTeamName,
                                isWin: semiTurn1.winTeamId == semiTurn1.aTeamId,
                              ))
                        ],
                      ),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          SizedBox(width: 200),
                          MatchTeamBracketLine(isLeft: true, height: 100),
                          Positioned(
                              left: 50,
                              child: MatchTeamBracketPlayer(
                                teamName: semiTurn1.bTeamName,
                                isWin: semiTurn1.winTeamId == semiTurn1.bTeamId,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      right: 0,
                      child: MatchTeamBracketPlayer(
                        teamName: finalTurn1.aTeamName,
                        isWin: finalTurn1.winTeamId == finalTurn1.aTeamId,
                      )),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: GogoColors.gray600),
                width: 60,
                height: 4,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Positioned(
                    top: 0,
                    child: Text(
                      '결승',
                      style: GogoTypography.caption2Extrabold
                          .copyWith(color: GogoColors.white),
                    ),
                  ),
                  MatchTeamBracketPlayer(
                    teamName: () {
                      if (finalTurn1.winTeamId == null) return 'TBD';
                      if (finalTurn1.aTeamId == finalTurn1.winTeamId) {
                        return finalTurn1.aTeamName;
                      }
                      if (finalTurn1.bTeamId == finalTurn1.winTeamId) {
                        return finalTurn1.bTeamName;
                      }
                      return 'TBD';
                    }(),
                    isWin: finalTurn1.isEnd,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: GogoColors.gray600),
                width: 60,
                height: 4,
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  SizedBox(
                    width: 300,
                  ),
                  Positioned(
                      left: 50,
                      child: MatchTeamBracketLine(isLeft: false, height: 200)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(width: 200),
                          MatchTeamBracketLine(isLeft: false, height: 100),
                          Positioned(
                              left: 50,
                              child: MatchTeamBracketPlayer(
                                teamName: semiTurn2.aTeamName,
                                isWin: semiTurn2.winTeamId == semiTurn2.aTeamId,
                              ))
                        ],
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(width: 200),
                          MatchTeamBracketLine(isLeft: false, height: 100),
                          Positioned(
                              left: 50,
                              child: MatchTeamBracketPlayer(
                                teamName: semiTurn2.bTeamName,
                                isWin: semiTurn2.winTeamId == semiTurn2.bTeamId,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      left: 0,
                      child: MatchTeamBracketPlayer(
                        teamName: finalTurn1.bTeamName,
                        isWin: finalTurn1.winTeamId == finalTurn1.bTeamId,
                      )),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MatchTeamBracketPlayer(
                    teamName: quarterTurn3.aTeamName,
                    isWin: quarterTurn3.winTeamId == quarterTurn3.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: quarterTurn3.bTeamName,
                    isWin: quarterTurn3.winTeamId == quarterTurn3.bTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: quarterTurn4.aTeamName,
                    isWin: quarterTurn4.winTeamId == quarterTurn4.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: quarterTurn4.bTeamName,
                    isWin: quarterTurn4.winTeamId == quarterTurn4.bTeamId,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 1100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '8강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                Text(
                  '4강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                Text(
                  '4강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                Text(
                  '8강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _round16Finals(SearchGameFormatResponse gameFormatResponse) {
    final TournamentMatch typedefMatch = TournamentMatch(
      matchId: 0,
      turn: 0,
      aTeamName: 'TBD',
      bTeamName: 'TBD',
      isEnd: false,
      winTeamId: -1,
    );

    final List<TournamentMatch> roundOf16Matches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.ROUND_OF_16)
        .match;
    TournamentMatch? round16Turn1 = roundOf16Matches
        .firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);
    TournamentMatch? round16Turn2 = roundOf16Matches
        .firstWhere((m) => m.turn == 2, orElse: () => typedefMatch);
    TournamentMatch? round16Turn3 = roundOf16Matches
        .firstWhere((m) => m.turn == 3, orElse: () => typedefMatch);
    TournamentMatch? round16Turn4 = roundOf16Matches
        .firstWhere((m) => m.turn == 4, orElse: () => typedefMatch);
    TournamentMatch? round16Turn5 = roundOf16Matches
        .firstWhere((m) => m.turn == 5, orElse: () => typedefMatch);
    TournamentMatch? round16Turn6 = roundOf16Matches
        .firstWhere((m) => m.turn == 6, orElse: () => typedefMatch);
    TournamentMatch? round16Turn7 = roundOf16Matches
        .firstWhere((m) => m.turn == 7, orElse: () => typedefMatch);
    TournamentMatch? round16Turn8 = roundOf16Matches
        .firstWhere((m) => m.turn == 8, orElse: () => typedefMatch);

    final List<TournamentMatch> quarterMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.QUARTER_FINALS)
        .match;
    TournamentMatch? quarterTurn1 = quarterMatches
        .firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);
    TournamentMatch? quarterTurn2 = quarterMatches
        .firstWhere((m) => m.turn == 2, orElse: () => typedefMatch);
    TournamentMatch? quarterTurn3 = quarterMatches
        .firstWhere((m) => m.turn == 3, orElse: () => typedefMatch);
    TournamentMatch? quarterTurn4 = quarterMatches
        .firstWhere((m) => m.turn == 4, orElse: () => typedefMatch);

    final List<TournamentMatch> semiMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.SEMI_FINALS)
        .match;
    TournamentMatch? semiTurn1 =
        semiMatches.firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);
    TournamentMatch? semiTurn2 =
        semiMatches.firstWhere((m) => m.turn == 2, orElse: () => typedefMatch);

    final List<TournamentMatch> finalMatches = gameFormatResponse.format
        .firstWhere((f) => f.round == MatchRound.FINALS)
        .match;
    TournamentMatch? finalTurn1 =
        finalMatches.firstWhere((m) => m.turn == 1, orElse: () => typedefMatch);
    return SizedBox(
      height: 450,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MatchTeamBracketPlayer(
                    teamName: round16Turn1.aTeamName,
                    isWin: round16Turn1.winTeamId == round16Turn1.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn1.bTeamName,
                    isWin: round16Turn1.winTeamId == round16Turn1.bTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn2.aTeamName,
                    isWin: round16Turn2.winTeamId == round16Turn2.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn2.bTeamName,
                    isWin: round16Turn2.winTeamId == round16Turn2.bTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn3.aTeamName,
                    isWin: round16Turn3.winTeamId == round16Turn3.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn3.bTeamName,
                    isWin: round16Turn3.winTeamId == round16Turn3.bTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn4.aTeamName,
                    isWin: round16Turn4.winTeamId == round16Turn4.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn4.bTeamName,
                    isWin: round16Turn4.winTeamId == round16Turn4.bTeamId,
                  ),
                ],
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 200,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MatchTeamBracketLine(isLeft: true, height: 80),
                      MatchTeamBracketLine(isLeft: true, height: 80),
                      MatchTeamBracketLine(isLeft: true, height: 80),
                      MatchTeamBracketLine(isLeft: true, height: 80),
                    ],
                  ),
                  Positioned(
                    height: 450,
                    left: 75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MatchTeamBracketPlayer(
                          teamName: quarterTurn1.aTeamName,
                          isWin: quarterTurn1.winTeamId == quarterTurn1.aTeamId,
                        ),
                        MatchTeamBracketPlayer(
                          teamName: quarterTurn1.bTeamName,
                          isWin: quarterTurn1.winTeamId == quarterTurn1.bTeamId,
                        ),
                        MatchTeamBracketPlayer(
                          teamName: quarterTurn2.aTeamName,
                          isWin: quarterTurn2.winTeamId == quarterTurn2.aTeamId,
                        ),
                        MatchTeamBracketPlayer(
                          teamName: quarterTurn2.bTeamName,
                          isWin: quarterTurn2.winTeamId == quarterTurn2.bTeamId,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(
                    width: 300,
                  ),
                  Positioned(
                      right: 50,
                      child: MatchTeamBracketLine(isLeft: true, height: 200)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          SizedBox(width: 200),
                          MatchTeamBracketLine(isLeft: true, height: 120),
                          Positioned(
                              left: 50,
                              child: MatchTeamBracketPlayer(
                                teamName: semiTurn1.aTeamName,
                                isWin: semiTurn1.winTeamId == semiTurn1.aTeamId,
                              ))
                        ],
                      ),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          SizedBox(width: 200),
                          MatchTeamBracketLine(isLeft: true, height: 120),
                          Positioned(
                              left: 50,
                              child: MatchTeamBracketPlayer(
                                teamName: semiTurn1.bTeamName,
                                isWin: semiTurn1.winTeamId == semiTurn1.bTeamId,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      right: 0,
                      child: MatchTeamBracketPlayer(
                        teamName: finalTurn1.aTeamName,
                        isWin: finalTurn1.winTeamId == finalTurn1.aTeamId,
                      )),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: GogoColors.gray600),
                width: 60,
                height: 4,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Positioned(
                    top: 0,
                    child: Text(
                      '결승',
                      style: GogoTypography.caption2Extrabold
                          .copyWith(color: GogoColors.white),
                    ),
                  ),
                  MatchTeamBracketPlayer(
                    teamName: () {
                      if (finalTurn1.winTeamId == null) return 'TBD';
                      if (finalTurn1.aTeamId == finalTurn1.winTeamId) {
                        return finalTurn1.aTeamName;
                      }
                      if (finalTurn1.bTeamId == finalTurn1.winTeamId) {
                        return finalTurn1.bTeamName;
                      }
                      return 'TBD';
                    }(),
                    isWin: finalTurn1.isEnd,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: GogoColors.gray600),
                width: 60,
                height: 4,
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  SizedBox(
                    width: 300,
                  ),
                  Positioned(
                      left: 50,
                      child: MatchTeamBracketLine(isLeft: false, height: 200)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(width: 200),
                          MatchTeamBracketLine(isLeft: false, height: 120),
                          Positioned(
                              left: 50,
                              child: MatchTeamBracketPlayer(
                                teamName: semiTurn2.aTeamName,
                                isWin: semiTurn2.winTeamId == semiTurn2.aTeamId,
                              ))
                        ],
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(width: 200),
                          MatchTeamBracketLine(isLeft: false, height: 120),
                          Positioned(
                              left: 50,
                              child: MatchTeamBracketPlayer(
                                teamName: semiTurn2.bTeamName,
                                isWin: semiTurn2.winTeamId == semiTurn2.bTeamId,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      left: 0,
                      child: MatchTeamBracketPlayer(
                        teamName: finalTurn1.bTeamName,
                        isWin: finalTurn1.winTeamId == finalTurn1.bTeamId,
                      )),
                ],
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  SizedBox(
                    width: 200,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MatchTeamBracketLine(isLeft: false, height: 80),
                      MatchTeamBracketLine(isLeft: false, height: 80),
                      MatchTeamBracketLine(isLeft: false, height: 80),
                      MatchTeamBracketLine(isLeft: false, height: 80),
                    ],
                  ),
                  Positioned(
                    height: 450,
                    left: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MatchTeamBracketPlayer(
                          teamName: quarterTurn3.aTeamName,
                          isWin: quarterTurn3.winTeamId == quarterTurn3.aTeamId,
                        ),
                        MatchTeamBracketPlayer(
                          teamName: quarterTurn3.bTeamName,
                          isWin: quarterTurn3.winTeamId == quarterTurn3.bTeamId,
                        ),
                        MatchTeamBracketPlayer(
                          teamName: quarterTurn4.aTeamName,
                          isWin: quarterTurn4.winTeamId == quarterTurn4.aTeamId,
                        ),
                        MatchTeamBracketPlayer(
                          teamName: quarterTurn4.bTeamName,
                          isWin: quarterTurn4.winTeamId == quarterTurn4.bTeamId,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MatchTeamBracketPlayer(
                    teamName: round16Turn5.aTeamName,
                    isWin: round16Turn5.winTeamId == round16Turn5.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn5.bTeamName,
                    isWin: round16Turn5.winTeamId == round16Turn5.bTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn6.aTeamName,
                    isWin: round16Turn6.winTeamId == round16Turn6.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn6.bTeamName,
                    isWin: round16Turn6.winTeamId == round16Turn6.bTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn7.aTeamName,
                    isWin: round16Turn7.winTeamId == round16Turn7.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn7.bTeamName,
                    isWin: round16Turn7.winTeamId == round16Turn7.bTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn8.aTeamName,
                    isWin: round16Turn8.winTeamId == round16Turn8.aTeamId,
                  ),
                  MatchTeamBracketPlayer(
                    teamName: round16Turn8.bTeamName,
                    isWin: round16Turn8.winTeamId == round16Turn8.bTeamId,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            width: 1490,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '16강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                Text(
                  '8강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                Text(
                  '4강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                Text(
                  '4강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                Text(
                  '8강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                Text(
                  '16강',
                  style: GogoTypography.caption2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final Map<String, dynamic> mockTournamentData = {
  "format": [
    {
      "round": "ROUND_OF_16",
      "match": [
        {
          "matchId": 1,
          "turn": 1,
          "aTeamId": 101,
          "aTeamName": "Team A",
          "bTeamId": 102,
          "bTeamName": "Team B",
          "isEnd": false,
          "winTeamId": null,
        },
        {
          "matchId": 2,
          "turn": 2,
          "aTeamId": 103,
          "aTeamName": "Team C",
          "bTeamId": 104,
          "bTeamName": "Team D",
          "isEnd": false,
          "winTeamId": null,
        },
        {
          "matchId": 3,
          "turn": 3,
          "aTeamId": 105,
          "aTeamName": "Team E",
          "bTeamId": 106,
          "bTeamName": "Team F",
          "isEnd": false,
          "winTeamId": null,
        },
        {
          "matchId": 4,
          "turn": 4,
          "aTeamId": 107,
          "aTeamName": "Team G",
          "bTeamId": 108,
          "bTeamName": "Team H",
          "isEnd": false,
          "winTeamId": null,
        },
        {
          "matchId": 5,
          "turn": 5,
          "aTeamId": 109,
          "aTeamName": "Team I",
          "bTeamId": 110,
          "bTeamName": "Team J",
          "isEnd": false,
          "winTeamId": null,
        },
        {
          "matchId": 6,
          "turn": 6,
          "aTeamId": 111,
          "aTeamName": "Team K",
          "bTeamId": 112,
          "bTeamName": "Team L",
          "isEnd": false,
          "winTeamId": null,
        },
        {
          "matchId": 7,
          "turn": 7,
          "aTeamId": 113,
          "aTeamName": "Team M",
          "bTeamId": 114,
          "bTeamName": "Team N",
          "isEnd": false,
          "winTeamId": null,
        },
        {
          "matchId": 8,
          "turn": 8,
          "aTeamId": 115,
          "aTeamName": "Team O",
          "bTeamId": 116,
          "bTeamName": "Team P",
          "isEnd": false,
          "winTeamId": null,
        },
      ],
    },
    {
      "round": "QUARTER_FINALS",
      "match": List.generate(
          4,
          (i) => {
                "matchId": 9 + i,
                "turn": i + 1,
                "aTeamId": -1,
                "aTeamName": "TBD",
                "bTeamId": -1,
                "bTeamName": "TBD",
                "isEnd": false,
                "winTeamId": null,
              }),
    },
    {
      "round": "SEMI_FINALS",
      "match": List.generate(
          2,
          (i) => {
                "matchId": 13 + i,
                "turn": i + 1,
                "aTeamId": -1,
                "aTeamName": "TBD",
                "bTeamId": -1,
                "bTeamName": "TBD",
                "isEnd": false,
                "winTeamId": null,
              }),
    },
    {
      "round": "FINALS",
      "match": [
        {
          "matchId": 15,
          "turn": 1,
          "aTeamId": -1,
          "aTeamName": "TBD",
          "bTeamId": -1,
          "bTeamName": "TBD",
          "isEnd": false,
          "winTeamId": null,
        },
      ],
    },
  ]
};
