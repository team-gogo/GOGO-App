import 'package:json_annotation/json_annotation.dart';

part 'search_participation_match_response.g.dart';

@JsonSerializable()
class SearchParticipationMatchResponse {
  final int count;
  final List<Team> team;

  SearchParticipationMatchResponse({
    required this.count,
    required this.team,
  });

  factory SearchParticipationMatchResponse.fromJson(Map<String, dynamic> json) =>
    _$SearchParticipationMatchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchParticipationMatchResponseToJson(this);
}

@JsonSerializable()
class Team {
  final int teamId;
  final String teamName;
  final int participantCount;
  final int winCount;

  Team({
    required this.teamId,
    required this.teamName,
    required this.participantCount,
    required this.winCount,
  });

  factory Team.fromJson(Map<String, dynamic> json) =>
    _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
