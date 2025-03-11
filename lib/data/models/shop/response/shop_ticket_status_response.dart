import 'package:json_annotation/json_annotation.dart';

part 'shop_ticket_status_response.g.dart';

@JsonSerializable()
class ShopTicketStatusResponse {
  final int shopId;
  final TicketInfo coinToss;
  final TicketInfo yavarwee;
  final TicketInfo plinko;

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
class TicketInfo {
  final int id;
  final int ticketPrice;
  final int ticketQuantity;

  TicketInfo({
    required this.id,
    required this.ticketPrice,
    required this.ticketQuantity,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) => _$TicketInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TicketInfoToJson(this);
}
