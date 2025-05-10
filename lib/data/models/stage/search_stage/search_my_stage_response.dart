import 'package:json_annotation/json_annotation.dart';

import '../enum_type/stage_type.dart';

part 'search_my_stage_response.g.dart';

enum StageStatus {
  RECRUITING,
  CONFIRMED,
  END,
}

@JsonSerializable()
class StageInfo {
  final int stageId;
  final String stageName;
  final List<StageType> type;
  final List<StageStatus> status;
  final bool isMaintaining;

  StageInfo({
    required this.stageId,
    required this.stageName,
    required this.type,
    required this.status,
    required this.isMaintaining,
  });

  factory StageInfo.fromJson(Map<String, dynamic> json) =>
      _$StageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StageInfoToJson(this);
}

@JsonSerializable()
class SearchMyStageResponse {
  final List<StageInfo> stages;

  SearchMyStageResponse({
    required this.stages,
  });

  factory SearchMyStageResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMyStageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMyStageResponseToJson(this);
}
