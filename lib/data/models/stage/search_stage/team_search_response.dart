import 'package:json_annotation/json_annotation.dart';

part 'team_search_response.g.dart';

@JsonSerializable()
class TeamSearchResponse {
  final int count;
  final List<Team> team;

  TeamSearchResponse({
    required this.count,
    required this.team,
  });

  factory TeamSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$TeamSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TeamSearchResponseToJson(this);
}

@JsonSerializable()
class Team {
  final int teamId;
  final String teamName;
  final int participantCount;

  Team({
    required this.teamId,
    required this.teamName,
    required this.participantCount,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
