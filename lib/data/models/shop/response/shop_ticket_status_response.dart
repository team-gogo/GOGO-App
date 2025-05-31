import 'package:json_annotation/json_annotation.dart';

part 'shop_ticket_status_response.g.dart';

@JsonSerializable()
class ShopTicketStatusResponse {
  final int shopId;
  final CoinTossTicket coinToss;
  final YavarweeTicket yavarwee;
  final PlinkoTicket plinko;

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
class CoinTossTicket {
  final int ticketPrice;
  final int ticketQuantity;

  CoinTossTicket({
    required this.ticketPrice,
    required this.ticketQuantity,
  });

  factory CoinTossTicket.fromJson(Map<String, dynamic> json) => _$CoinTossTicketFromJson(json);
  Map<String, dynamic> toJson() => _$CoinTossTicketToJson(this);
}

@JsonSerializable()
class YavarweeTicket {
  final int ticketPrice;
  final int ticketQuantity;

  YavarweeTicket({
    required this.ticketPrice,
    required this.ticketQuantity,
  });

  factory YavarweeTicket.fromJson(Map<String, dynamic> json) => _$YavarweeTicketFromJson(json);
  Map<String, dynamic> toJson() => _$YavarweeTicketToJson(this);
}

@JsonSerializable()
class PlinkoTicket {
  final int ticketPrice;
  final int ticketQuantity;

  PlinkoTicket({
    required this.ticketPrice,
    required this.ticketQuantity,
  });

  factory PlinkoTicket.fromJson(Map<String, dynamic> json) => _$PlinkoTicketFromJson(json);
  Map<String, dynamic> toJson() => _$PlinkoTicketToJson(this);
}
