import 'package:gogo_app/data/repositories/mini_game/ws/plinko/plinko_web_socket_repository.dart';

import '../../../../data_sources/ws/web_socket_data_source.dart';
import '../../../../models/mini_game/ws/plinko_response.dart';

class PlinkoWebSocketRepositoryImpl implements PlinkoWebSocketRepository {
  final WebSocketDataSource _webSocketDataSource;

  PlinkoWebSocketRepositoryImpl(this._webSocketDataSource);

  @override
  void sendBet(int amount, String risk) {
    final request = {"amount": amount, "risk": risk};
    _webSocketDataSource.sendMessage(request);
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
