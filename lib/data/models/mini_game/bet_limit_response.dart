import 'package:json_annotation/json_annotation.dart';

part 'bet_limit_response.g.dart';

@JsonSerializable()
class BetLimitResponse {
  final GameBetSetting plinko;
  final GameBetSetting yavarwee;
  final GameBetSetting coinToss;

  const BetLimitResponse({
    required this.plinko,
    required this.yavarwee,
    required this.coinToss,
  });

  factory BetLimitResponse.fromJson(Map<String, dynamic> json) =>
      _$BetLimitResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BetLimitResponseToJson(this);
}

@JsonSerializable()
class GameBetSetting {
  final int? minBetPoint;
  final int? maxBetPoint;

  const GameBetSetting({this.minBetPoint, this.maxBetPoint});

  factory GameBetSetting.fromJson(Map<String, dynamic> json) =>
      _$GameBetSettingFromJson(json);
  Map<String, dynamic> toJson() => _$GameBetSettingToJson(this);
}