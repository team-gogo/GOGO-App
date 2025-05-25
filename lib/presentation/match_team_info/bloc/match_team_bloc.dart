import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_game_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_response.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/match_team_info/bloc/match_team_event.dart';
import 'package:gogo_app/presentation/match_team_info/bloc/match_team_state.dart';

class MatchTeamBloc extends Bloc<MatchTeamEvent, MatchTeamState> {
  MatchTeamBloc() : super(InitMatchTeam()) {
    on<GetGameList>(_getGameList);
    on<GetMatchTeam>(_getMatchTeam);
  }

  final StageRepository _stageRepository = GetIt.instance<StageRepository>();
  late SearchGameResponse gameResponse;

  void _getGameList(GetGameList event, Emitter<MatchTeamState> emit) async {
    emit(LoadingMatchTeam());
    try {
      gameResponse = await _stageRepository.getGame(event.stageId);
      add(GetMatchTeam());
    } catch (e) {
      emit(ErrorMatchTeam(error: e.toString()));
    }
  }

  void _getMatchTeam(GetMatchTeam event, Emitter<MatchTeamState> emit) async {
    emit(LoadingMatchTeam());
    try {
      final response = gameResponse.games
          .map((index) async => await _stageRepository.getTeams(index.gameId))
          .toList();
      final List<SearchTeamResponse> teamResponse = await Future.wait(response);
      emit(LoadedMatchTeam(
          teamResponse: teamResponse, gameResponse: gameResponse));
    } catch (e) {
      emit(ErrorMatchTeam(error: e.toString()));
    }
  }
}
