import 'package:json_annotation/json_annotation.dart';

part 'match_settle_request.g.dart'; // 생성될 파일 이름

@JsonSerializable()
class MatchSettleRequest {
  final int winTeamId;
  final int aTeamScore;
  final int bTeamScore;

  MatchSettleRequest({
    required this.winTeamId,
    required this.aTeamScore,
    required this.bTeamScore,
  });

  factory MatchSettleRequest.fromJson(Map<String, dynamic> json) => _$MatchSettleRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MatchSettleRequestToJson(this);
}
