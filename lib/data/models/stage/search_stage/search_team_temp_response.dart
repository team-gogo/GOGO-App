import 'package:json_annotation/json_annotation.dart';

part 'search_team_temp_response.g.dart';

@JsonSerializable()
class SearchTempTeamResponse {
  final int count;
  final List<TempTeam> team;

  SearchTempTeamResponse({
    required this.count,
    required this.team,
  });

  factory SearchTempTeamResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchTempTeamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTempTeamResponseToJson(this);
}

@JsonSerializable()
class TempTeam {
  final int teamId;
  final String teamName;
  final int participantCount;

  TempTeam({
    required this.teamId,
    required this.teamName,
    required this.participantCount,
  });

  factory TempTeam.fromJson(Map<String, dynamic> json) =>
      _$TempTeamFromJson(json);

  Map<String, dynamic> toJson() => _$TempTeamToJson(this);
}
