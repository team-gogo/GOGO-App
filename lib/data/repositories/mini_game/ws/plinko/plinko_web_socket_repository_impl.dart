import 'package:gogo_app/data/repositories/mini_game/ws/plinko/plinko_web_socket_repository.dart';

import '../../../../data_sources/ws/web_socket_data_sources.dart';
import '../../../../models/mini_game/ws/plinko_response.dart';

class PlinkoWebSocketRepositoryImpl implements PlinkoWebSocketRepository {
  final WebSocketDataSources _webSocketDataSources;

  PlinkoWebSocketRepositoryImpl(this._webSocketDataSources);

  @override
  void sendBet(int amount, String risk) {
    final request = {"amount": amount, "risk": risk};
    _webSocketDataSources.sendMessage(request);
  }

  @override
  Stream<PlinkoResponse> listenForResponses() {
    return _webSocketDataSources.messages
        .map((event) => PlinkoResponse.fromJson(event));
  }

  @override
  void closeConnection() {
    _webSocketDataSources.close();
  }
}
