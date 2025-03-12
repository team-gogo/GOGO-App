import 'package:json_annotation/json_annotation.dart';

part 'shop_ticket_status_response.g.dart';

@JsonSerializable()
class ShopTicketStatusResponse {
  final int shopId;
  final CoinToss coinToss;
  final Yavarwee yavarwee;
  final Plinko plinko;

  ShopTicketStatusResponse({
    required this.shopId,
    required this.coinToss,
    required this.yavarwee,
    required this.plinko,
  });

  factory ShopTicketStatusResponse.fromJson(Map<String, dynamic> json) => _$ShopTicketStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShopTicketStatusResponseToJson(this);
}

@JsonSerializable()
class CoinToss {
  final int coinTossId;
  final int ticketPrice;
  final int ticketQuantity;

  CoinToss({
    required this.coinTossId,
    required this.ticketPrice,
    required this.ticketQuantity,
  });

  factory CoinToss.fromJson(Map<String, dynamic> json) => _$CoinTossFromJson(json);
  Map<String, dynamic> toJson() => _$CoinTossToJson(this);
}

@JsonSerializable()
class Yavarwee {
  final int yavarweeId;
  final int ticketPrice;
  final int ticketQuantity;

  Yavarwee({
    required this.yavarweeId,
    required this.ticketPrice,
    required this.ticketQuantity,
  });

  factory Yavarwee.fromJson(Map<String, dynamic> json) => _$YavarweeFromJson(json);
  Map<String, dynamic> toJson() => _$YavarweeToJson(this);
}

@JsonSerializable()
class Plinko {
  final int plinkoId;
  final int ticketPrice;
  final int ticketQuantity;

  Plinko({
    required this.plinkoId,
    required this.ticketPrice,
    required this.ticketQuantity,
  });

  factory Plinko.fromJson(Map<String, dynamic> json) => _$PlinkoFromJson(json);
  Map<String, dynamic> toJson() => _$PlinkoToJson(this);
}
