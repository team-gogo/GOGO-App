import 'package:gogo_app/data/models/shop/request/buy_shop_item_request.dart';
import 'package:gogo_app/data/models/shop/response/shop_receipt_response.dart';

import '../../models/shop/response/shop_ticket_status_response.dart';

abstract class ShopDataSource {
  Future<ShopTicketStatusResponse> shopTicketStatusResponse (int stageId);
  Future<ReceiptItem> getReceiptItem(int shopId);
  Future<void> buyShopItemRequest(int shopId, BuyShopItemRequest body);
}