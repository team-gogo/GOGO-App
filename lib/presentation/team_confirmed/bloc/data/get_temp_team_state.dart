

import '../../../../data/models/stage/search_stage/search_team_temp_response.dart';

sealed class GetTempTeamState {}

final class GetTempTeamInitial extends GetTempTeamState {}

class GetTempTeamLoading extends GetTempTeamState {}

class GetTempTeamLoaded extends GetTempTeamState {
  final SearchTempTeamResponse tempTeamResponse;

  GetTempTeamLoaded({required this.tempTeamResponse});
}

class GetTempTeamError extends GetTempTeamState {
  final String message;

  GetTempTeamError({required this.message});
}
