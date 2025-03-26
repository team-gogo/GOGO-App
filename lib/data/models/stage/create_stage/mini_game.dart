import 'package:json_annotation/json_annotation.dart';

part 'mini_game.g.dart';

@JsonSerializable()
class FastMiniGame {
  final MiniGameCreateRequest coinToss;

  FastMiniGame({
    required this.coinToss,
  });

  factory FastMiniGame.fromJson(Map<String, dynamic> json) =>
      _$FastMiniGameFromJson(json);

  Map<String, dynamic> toJson() => _$FastMiniGameToJson(this);
}

@JsonSerializable()
class OfficialMiniGame {
  final MiniGameCreateRequest coinToss;
  final MiniGameCreateRequest yavarwee;
  final MiniGameCreateRequest plinko;

  OfficialMiniGame({
    required this.coinToss,
    required this.yavarwee,
    required this.plinko,
  });

  factory OfficialMiniGame.fromJson(Map<String, dynamic> json) =>
      _$OfficialMiniGameFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialMiniGameToJson(this);
}

@JsonSerializable()
class MiniGameCreateRequest {
  final bool isActive;
  final int? maxBettingPoint;
  final int? minBettingPoint;
  final int? initialTicketCount;

  MiniGameCreateRequest({
    required this.isActive,
    this.maxBettingPoint,
    this.minBettingPoint,
    this.initialTicketCount,
  });

  factory MiniGameCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$MiniGameCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MiniGameCreateRequestToJson(this);
}
