import 'package:json_annotation/json_annotation.dart';

part 'search_team_response.g.dart';

@JsonSerializable()
class SearchTeamResponse {
  final int count;
  final List<SearchTeam> team;

  const SearchTeamResponse({
    required this.count,
    required this.team,
  });

  factory SearchTeamResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchTeamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTeamResponseToJson(this);
}

@JsonSerializable()
class SearchTeam {
  final int teamId;
  final String teamName;
  final int participantCount;
  final int winCount;

  SearchTeam({
    required this.teamId,
    required this.teamName,
    required this.participantCount,
    required this.winCount,
  });

  factory SearchTeam.fromJson(Map<String, dynamic> json) =>
      _$SearchTeamFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTeamToJson(this);
}
