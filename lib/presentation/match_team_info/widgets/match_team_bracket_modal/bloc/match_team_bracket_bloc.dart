import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'match_team_bracket_event.dart';
import 'match_team_bracket_state.dart';

class MatchTeamBracketBloc
    extends Bloc<MatchTeamBracketEvent, MatchTeamBracketState> {
  MatchTeamBracketBloc() : super(InitMatchTeamBracket()) {
    on<GetMatchTeamBracket>(_getMatchTeamBracket);
  }

  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  void _getMatchTeamBracket(
    GetMatchTeamBracket event,
    Emitter<MatchTeamBracketState> emit,
  ) async {
    emit(LoadingMatchTeamBracket());
    try {
      final response = await _stageRepository.getGameFormat(event.gameId);
      emit(LoadedMatchTeamBracket(
        gameFormatResponse: response,
      ));
    } catch (e) {
      print(e.toString());
      emit(ErrorMatchTeamBracket(
        errorMessage: e.toString(),
      ));
    }
  }

}
