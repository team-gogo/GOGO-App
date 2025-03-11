import '../../../../data_sources/ws/web_socket_data_source.dart';
import '../../../../models/mini_game/ws/amount_dto.dart';
import '../../../../models/mini_game/ws/coin_toss_response.dart';
import 'coin_toss_web_socket_repository.dart';

class CoinTossWebSocketRepositoryImpl implements CoinTossWebSocketRepository {
  final WebSocketDataSource _webSocketDataSource;

  CoinTossWebSocketRepositoryImpl(this._webSocketDataSource);

  @override
  void connect(String stageId) {
    _webSocketDataSource
        .connect("wss://echo.websocket.org" + "/coin-toss/$stageId");
  }

  @override
  void sendAmount(AmountDTO amount) {
    _webSocketDataSource.sendMessage(amount.toJson());
  }

  @override
  Stream<CoinTossResponse> listenForResponses() {
    return _webSocketDataSource.messages
        .map((event) => CoinTossResponse.fromJson(event));
  }

  @override
  void closeConnection() {
    _webSocketDataSource.close();
  }
}
