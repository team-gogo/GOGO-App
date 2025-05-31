import 'package:json_annotation/json_annotation.dart';

part 'check_stage_admin_response.g.dart';

@JsonSerializable()
class CheckStageAdminResponse {
  final bool isMaintainer;

  CheckStageAdminResponse({required this.isMaintainer});

  factory CheckStageAdminResponse.fromJson(Map<String, dynamic> json) => _$CheckStageAdminResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckStageAdminResponseToJson(this);
}