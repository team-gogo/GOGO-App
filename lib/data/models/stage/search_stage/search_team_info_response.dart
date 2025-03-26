import 'package:json_annotation/json_annotation.dart';
part 'search_team_info_response.g.dart';

@JsonSerializable()
class SearchTeamInfoResponse {
  final int teamId;
  final String teamName;
  final int bettingPoint;
  final int winCount;
  final List<TeamInfoParticipant> participants;

  SearchTeamInfoResponse({
    required this.teamId,
    required this.teamName,
    required this.bettingPoint,
    required this.winCount,
    required this.participants,
  });

  factory SearchTeamInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchTeamInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTeamInfoResponseToJson(this);
}

@JsonSerializable()
class TeamInfoParticipant {
  final int studentId;
  final String name;
  final int classNumber;
  final int studentNumber;
  final String positionX;
  final String positionY;

  TeamInfoParticipant({
    required this.studentId,
    required this.name,
    required this.classNumber,
    required this.studentNumber,
    required this.positionX,
    required this.positionY,
  });

  factory TeamInfoParticipant.fromJson(Map<String, dynamic> json) =>
      _$TeamInfoParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$TeamInfoParticipantToJson(this);
}
