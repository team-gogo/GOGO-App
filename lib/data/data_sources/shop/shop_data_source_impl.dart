import 'package:dio/dio.dart';
import 'package:gogo_app/data/data_sources/shop/shop_data_source.dart';
import 'package:gogo_app/data/models/shop/request/buy_shop_item_request.dart';
import 'package:gogo_app/data/models/shop/response/shop_receipt_response.dart';
import 'package:gogo_app/data/models/shop/response/shop_ticket_status_response.dart';
import '../../api/shop_api.dart';
import '../../util/execute_handle_api_call.dart';

class ShopDataSourceImpl implements ShopDataSource {
  final ShopApi _shopApi;

  ShopDataSourceImpl(Dio dio) : _shopApi = ShopApi(dio);

  @override
  Future<void> buyShopItemRequest(int shopId, BuyShopItemRequest body) async {
    return await executeHandleApiCall(() => _shopApi.buyShopItem(shopId, body));
  }

  @override
  Future<ReceiptItem> getReceiptItem(int shopId) async {
    return await executeHandleApiCall(() => _shopApi.getShopReceipt(shopId));
  }

  @override
  Future<ShopTicketStatusResponse> shopTicketStatusResponse(int stageId) async {
    return await executeHandleApiCall(() => _shopApi.getShopTicketStatus(stageId));
  }
}