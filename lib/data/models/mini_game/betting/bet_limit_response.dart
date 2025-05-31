import 'package:json_annotation/json_annotation.dart';

part 'bet_limit_response.g.dart';

@JsonSerializable()
class BetLimitResponse {
  final GameBetLimit plinko;
  final GameBetLimit yavarwee;
  final GameBetLimit coinToss;

  BetLimitResponse({
    required this.plinko,
    required this.yavarwee,
    required this.coinToss,
  });

  factory BetLimitResponse.fromJson(Map<String, dynamic> json) =>
      _$BetLimitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BetLimitResponseToJson(this);
}

@JsonSerializable()
class GameBetLimit {
  final int? minBetPoint;
  final int? maxBetPoint;

  GameBetLimit({
    this.minBetPoint,
    this.maxBetPoint,
  });

  factory GameBetLimit.fromJson(Map<String, dynamic> json) =>
      _$GameBetLimitFromJson(json);

  Map<String, dynamic> toJson() => _$GameBetLimitToJson(this);
} 