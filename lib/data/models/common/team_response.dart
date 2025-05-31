import 'package:json_annotation/json_annotation.dart';
part 'team_response.g.dart';

@JsonSerializable()
class Team {
  final int teamId;
  final String teamName;
  final int bettingPoint;
  final int winCount;
  final List<Participant> participants;

  Team({
    required this.teamId,
    required this.teamName,
    required this.bettingPoint,
    required this.winCount,
    required this.participants,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}


@JsonSerializable()
class Participant {
  final int studentId;
  final String name;
  final int classNumber;
  final int studentNumber;
  final String positionX;
  final String positionY;

  Participant({
    required this.studentId,
    required this.name,
    required this.classNumber,
    required this.studentNumber,
    required this.positionX,
    required this.positionY,
  });

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
