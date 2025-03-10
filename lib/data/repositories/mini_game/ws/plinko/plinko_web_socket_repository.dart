abstract class PlinkoWebSocketRepository {
  void sendBet(int amount, String risk);

  Stream<Map<String, dynamic>> listenForResponses();

  void closeConnection();
}
