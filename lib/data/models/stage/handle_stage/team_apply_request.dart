import 'package:json_annotation/json_annotation.dart';

part 'team_apply_request.g.dart';

@JsonSerializable()
class TeamApplyRequest {
  final String teamName;
  final List<ApplyParticipant> participants;

  TeamApplyRequest({
    required this.teamName,
    required this.participants,
  });

  factory TeamApplyRequest.fromJson(Map<String, dynamic> json) =>
      _$TeamApplyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TeamApplyRequestToJson(this);
}

@JsonSerializable()
class ApplyParticipant {
  final int studentId;
  final String positionX;
  final String positionY;

  ApplyParticipant({
    required this.studentId,
    required this.positionX,
    required this.positionY,
  });

  factory ApplyParticipant.fromJson(Map<String, dynamic> json) =>
      _$ApplyParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyParticipantToJson(this);
}
