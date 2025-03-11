import 'package:dio/dio.dart';
import 'package:gogo_app/data/models/shop/request/buy_shop_item_request.dart';
import 'package:gogo_app/data/models/shop/response/shop_receipt_response.dart';
import 'package:gogo_app/data/models/shop/response/shop_ticket_status_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'shop_api.g.dart';

@RestApi()
abstract class ShopApi {
  factory ShopApi(Dio dio, {String baseUrl}) = _ShopApi;

  @GET('/shop/{stage_id}')
  Future<ShopTicketStatusResponse> getShopTicketStatus(
      @Path('stage_id') int stageId);
  
  @GET('/shop/receipt/{shop_id}')
  Future <ShopReceiptResponse> getShopReceipt(
      @Path('shop_id') int shopId);

  @POST('/shop/{shop_id}')
  Future<void> buyShopItem(
      @Path('shop_id') int shopId,
      @Body() BuyShopItemRequest body);
}
