import 'package:json_annotation/json_annotation.dart';
import '../enum_type/ticket_type.dart';

part 'buy_shop_item_request.g.dart';

@JsonSerializable()
class BuyShopItemRequest {
  final int miniGameId;
  final int ticketQuantity;
  final TicketType ticketType;

  BuyShopItemRequest({
    required this.miniGameId,
    required this.ticketQuantity,
    required this.ticketType,
  });

  factory BuyShopItemRequest.fromJson(Map<String, dynamic> json) => _$BuyShopItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BuyShopItemRequestToJson(this);
}