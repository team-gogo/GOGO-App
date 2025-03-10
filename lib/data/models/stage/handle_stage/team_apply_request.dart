import 'package:json_annotation/json_annotation.dart';

part 'team_apply_request.g.dart';

@JsonSerializable()
class TeamApplyRequest {
  final String teamName;
  final Participant participant;

  TeamApplyRequest({
    required this.teamName,
    required this.participant,
  });

  factory TeamApplyRequest.fromJson(Map<String, dynamic> json) =>
      _$TeamApplyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TeamApplyRequestToJson(this);
}

@JsonSerializable()
class Participant {
  final int studentId;
  final double positionX;
  final double positionY;

  Participant({
    required this.studentId,
    required this.positionX,
    required this.positionY,
  });

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
