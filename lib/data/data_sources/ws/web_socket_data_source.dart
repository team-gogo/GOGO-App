abstract class WebSocketDataSource {
  void sendMessage(Map<String, dynamic> message);
  Stream<Map<String, dynamic>> get messages;
  void close();
}
