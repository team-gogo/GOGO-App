import 'package:json_annotation/json_annotation.dart';

part 'betting_match_request.g.dart';

@JsonSerializable()
class BettingMatchRequest {
  final int predictedWinTeamId;
  final int bettingPoint;

  BettingMatchRequest({
    required this.predictedWinTeamId,
    required this.bettingPoint,
  });

  factory BettingMatchRequest.fromJson(Map<String, dynamic> json) => _$BettingMatchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BettingMatchRequestToJson(this);
}
