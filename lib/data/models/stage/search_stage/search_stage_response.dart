import 'package:json_annotation/json_annotation.dart';

import '../enum_type/stage_type.dart';

part 'search_stage_response.g.dart';

@JsonSerializable()
class SearchStageResponse {
  final int count;
  final List<Stage> stages;

  SearchStageResponse({
    required this.count,
    required this.stages,
  });

  factory SearchStageResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchStageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchStageResponseToJson(this);
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
  final bool isMaintainer;
  final bool isPassCode;

  Stage({
    required this.stageId,
    required this.stageName,
    required this.type,
    required this.status,
    required this.participantCount,
    required this.isParticipating,
    required this.isMaintainer,
    required this.isPassCode,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);

  Map<String, dynamic> toJson() => _$StageToJson(this);
}
