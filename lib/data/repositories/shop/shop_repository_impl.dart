import 'package:gogo_app/data/data_sources/shop/shop_data_source.dart';
import 'package:gogo_app/data/models/shop/request/buy_shop_item_request.dart';
import 'package:gogo_app/data/models/shop/response/shop_receipt_response.dart';
import 'package:gogo_app/data/models/shop/response/shop_ticket_status_response.dart';
import 'package:gogo_app/data/repositories/shop/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopDataSource _shopDataSource;

  ShopRepositoryImpl(this._shopDataSource);

  @override
  Future<void> buyShopItemRequest(int shopId, BuyShopItemRequest body) {
    return _shopDataSource.buyShopItemRequest(shopId, body);
  }

  @override
  Future<ReceiptItem> getReceiptItem(int shopId) {
    return _shopDataSource.getReceiptItem(shopId);
  }

  @override
  Future<ShopTicketStatusResponse> shopTicketStatusResponse(int stageId) {
    return _shopDataSource.shopTicketStatusResponse(stageId);
  }
}