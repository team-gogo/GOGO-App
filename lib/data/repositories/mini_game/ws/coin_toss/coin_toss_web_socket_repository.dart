import '../../../../models/mini_game/ws/amount_dto.dart';
import '../../../../models/mini_game/ws/coin_toss_response.dart';

abstract class CoinTossWebSocketRepository {
  void connect(String stageId);

  void sendAmount(AmountDTO amount);

  Stream<CoinTossResponse> listenForResponses();

  void closeConnection();
}
