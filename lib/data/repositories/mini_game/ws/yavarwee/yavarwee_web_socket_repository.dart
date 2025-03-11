import '../../../../models/mini_game/ws/amount_dto.dart';
import '../../../../models/mini_game/ws/yavarwee_request.dart';

abstract class YavarweeWebSocketRepository {
  void connect(String stageId);

  void sendAmount(YavarweeRequest body);

  Stream<AmountDTO> listenForResponses();

  void closeConnection();
}
