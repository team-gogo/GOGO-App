import '../../../../models/mini_game/ws/plinko_response.dart';

abstract class PlinkoWebSocketRepository {
  void connect(String stageId);

  void sendBet(int amount, String risk);

  Stream<PlinkoResponse> listenForResponses();

  void closeConnection();
}
