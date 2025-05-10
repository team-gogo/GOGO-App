import 'package:json_annotation/json_annotation.dart';

part 'search_stage_participant_response.g.dart';

@JsonSerializable()
class SearchStageParticipantResponse {
  final int isParticipant;

  SearchStageParticipantResponse({required this.isParticipant});

  factory SearchStageParticipantResponse.fromJson(Map<String, dynamic> json) =>
    _$SearchStageParticipantResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchStageParticipantResponseToJson(this);
}