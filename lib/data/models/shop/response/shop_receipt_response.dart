import 'package:json_annotation/json_annotation.dart';
import '../enum_type/ticket_type.dart';

part 'shop_receipt_response.g.dart';

@JsonSerializable()
class ShopReceiptResponse {
  final List<ReceiptItem> receipt;

  ShopReceiptResponse({required this.receipt});

  factory ShopReceiptResponse.fromJson(Map<String, dynamic> json) => _$ShopReceiptResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShopReceiptResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReceiptItem {
  final int ticketPrice;
  final int ticketQuantity;
  final TicketType ticketType;
  final DateTime purchaseDate;

  ReceiptItem({
    required this.ticketPrice,
    required this.ticketQuantity,
    required this.ticketType,
    required this.purchaseDate,
  });

  factory ReceiptItem.fromJson(Map<String, dynamic> json) =>
      _$ReceiptItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptItemToJson(this);
}
