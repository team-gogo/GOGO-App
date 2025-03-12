import 'package:gogo_app/data/repositories/mini_game/ws/plinko/plinko_web_socket_repository.dart';

import '../../../../data_sources/ws/web_socket_data_source.dart';
import '../../../../models/mini_game/ws/plinko_Request.dart';
import '../../../../models/mini_game/ws/plinko_response.dart';

class PlinkoWebSocketRepositoryImpl implements PlinkoWebSocketRepository {
  final WebSocketDataSource _webSocketDataSource;

  PlinkoWebSocketRepositoryImpl(this._webSocketDataSource);

  @override
  void connect(String stageId) {
    _webSocketDataSource
        .connect("wss://echo.websocket.org" + "/plinko/$stageId");
  }

  @override
  void sendBet(PlinkoRequest body) {
    _webSocketDataSource.sendMessage(body.toJson());
  }

  @override
  Stream<PlinkoResponse> listenForResponses() {
    return _webSocketDataSource.messages
        .map((event) => PlinkoResponse.fromJson(event));
  }

  @override
  void closeConnection() {
    _webSocketDataSource.close();
  }
}
