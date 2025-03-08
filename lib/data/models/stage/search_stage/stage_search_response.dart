import 'package:json_annotation/json_annotation.dart';

import '../stage_type.dart';

part 'stage_search_response.g.dart';

@JsonSerializable()
class StageSearchResponse {
  final int count;
  final List<Stage> stage;

  StageSearchResponse({
    required this.count,
    required this.stage,
  });

  factory StageSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$StageSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StageSearchResponseToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum StageStatus {
  @JsonValue("RECRUITING")
  RECRUITING,
  @JsonValue("CONFIRMED")
  CONFIRMED,
  @JsonValue("END")
  END,
}

@JsonSerializable()
class Stage {
  final int stageId;
  final String stageName;
  final StageType type;
  final StageStatus status;
  final int participantCount;
  final bool isParticipating;

  Stage({
    required this.stageId,
    required this.stageName,
    required this.type,
    required this.status,
    required this.participantCount,
    required this.isParticipating,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson() => _$StageToJson(this);
}
