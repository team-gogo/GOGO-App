
import '../../../../models/mini_game/ws/coin_toss_response.dart';

abstract class CoinTossWebSocketRepository {
  void connect(String stageId);

  void sendAmount(int amount);

  Stream<CoinTossResponse> listenForResponses();

  void closeConnection();
}
