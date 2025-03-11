import 'dart:convert';

import 'package:gogo_app/data/data_sources/ws/web_socket_data_source.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketDataSourceImpl implements WebSocketDataSource {
  late final WebSocketChannel _channel;

  WebSocketDataSourcesImpl(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  @override
  void sendMessage(Map<String, dynamic> message) {
    final jsonString = jsonEncode(message);
    _channel.sink.add(jsonString);
  }

  @override
  Stream<Map<String, dynamic>> get messages => _channel.stream.map((event) {
        return jsonDecode(event) as Map<String, dynamic>;
      });

  @override
  void close() {
    _channel.sink.close(status.normalClosure);
  }
}
