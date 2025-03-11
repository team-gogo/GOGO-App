import '../../models/shop/request/buy_shop_item_request.dart';
import '../../models/shop/response/shop_receipt_response.dart';
import '../../models/shop/response/shop_ticket_status_response.dart';

abstract class ShopRepository {
  Future<ShopTicketStatusResponse> shopTicketStatusResponse (int stageId);
  Future<ShopReceiptResponse> getReceiptItem(int shopId);
  Future<void> buyShopItemRequest(int shopId, BuyShopItemRequest body);
}