import 'package:json_annotation/json_annotation.dart';

part 'join_stage_request.g.dart';

@JsonSerializable()
class JoinStageRequest {
  final String? passCode;

  JoinStageRequest({this.passCode});

  factory JoinStageRequest.fromJson(Map<String, dynamic> json) => _$JoinStageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$JoinStageRequestToJson(this);
}