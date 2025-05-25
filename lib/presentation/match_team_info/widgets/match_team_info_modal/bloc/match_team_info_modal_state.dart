import 'package:gogo_app/data/models/stage/search_stage/search_team_info_response.dart';

abstract class MatchTeamInfoModalState {
  const MatchTeamInfoModalState();
}

class InitMatchTeamInfo extends MatchTeamInfoModalState {}

class LoadingMatchTeamInfo extends MatchTeamInfoModalState {}

class LoadedMatchTeamInfo extends MatchTeamInfoModalState {
  final SearchTeamInfoResponse teamInfoResponse;

  const LoadedMatchTeamInfo({required this.teamInfoResponse});
}

class ErrorMatchTeamInfo extends MatchTeamInfoModalState {
  final String error;

  const ErrorMatchTeamInfo({required this.error});
}
