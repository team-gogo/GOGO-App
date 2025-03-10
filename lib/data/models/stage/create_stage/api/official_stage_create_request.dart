import 'package:json_annotation/json_annotation.dart';

import '../game.dart';
import '../mini_game.dart';
import '../rule.dart';

part 'official_stage_create_request.g.dart';

@JsonSerializable()
class OfficialStageCreateRequest {
  final String stageName;
  final List<Game> game;
  final int initialPoint;
  final Rule rule;
  final MiniGame miniGame;
  final Shop shop;
  final String? passCode;
  final List<int> maintainer;

  OfficialStageCreateRequest({
    required this.stageName,
    required this.game,
    required this.initialPoint,
    required this.rule,
    required this.miniGame,
    required this.shop,
    this.passCode,
    required this.maintainer,
  });

  factory OfficialStageCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$OfficialStageCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OfficialStageCreateRequestToJson(this);
}

@JsonSerializable()
class Shop {
  final ShopItem coinToss;
  final ShopItem yavarwee;
  final ShopItem plinko;

  Shop({
    required this.coinToss,
    required this.yavarwee,
    required this.plinko,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
  Map<String, dynamic> toJson() => _$ShopToJson(this);
}

@JsonSerializable()
class ShopItem {
  final bool isActive;
  final int? price;
  final int? quantity;

  ShopItem({
    required this.isActive,
    this.price,
    this.quantity,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) =>
      _$ShopItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShopItemToJson(this);
}
