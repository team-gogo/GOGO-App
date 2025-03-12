import '../../../../models/mini_game/ws/plinko_request.dart';
import '../../../../models/mini_game/ws/plinko_response.dart';

abstract class PlinkoWebSocketRepository {
  void connect(String stageId);

  void sendBet(PlinkoRequest body);

  Stream<PlinkoResponse> listenForResponses();

  void closeConnection();
}
