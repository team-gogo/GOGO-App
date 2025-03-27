import 'package:gogo_app/data/models/stage/search_stage/search_my_stage_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enum_type/stage_type.dart';
import '../search_information/search_match_information_response.dart';
part 'search_my_team_response.g.dart';

@JsonSerializable()
class SearchMyTeamResponse {
  final List<Stage> stages;

  SearchMyTeamResponse({
    required this.stages,
  });

  factory SearchMyTeamResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMyTeamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMyTeamResponseToJson(this);
}

@JsonSerializable()
class MyStage {
  final int stageId;
  final String stageName;
  final StageType type;
  final StageStatus status;
  final bool isMaintaining;

  MyStage({
    required this.stageId,
    required this.stageName,
    required this.type,
    required this.status,
    required this.isMaintaining,
  });

  factory MyStage.fromJson(Map<String, dynamic> json) =>
      _$MyStageFromJson(json);

  Map<String, dynamic> toJson() => _$MyStageToJson(this);
}
