import 'package:gogo_app/data/models/stage/search_stage/search_game_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_response.dart';

abstract class MatchTeamState {
  const MatchTeamState();
}

class InitMatchTeam extends MatchTeamState {}

class LoadingMatchTeam extends MatchTeamState {}

class LoadedMatchTeam extends MatchTeamState {
  final List<SearchTeamResponse> teamResponse;
  final SearchGameResponse gameResponse;

  const LoadedMatchTeam({
    required this.teamResponse,
    required this.gameResponse,
  });
}

class ErrorMatchTeam extends MatchTeamState {
  final String error;

  const ErrorMatchTeam({required this.error});
}
