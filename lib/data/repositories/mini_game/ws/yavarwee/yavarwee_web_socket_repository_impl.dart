import 'dart:convert';

import 'package:gogo_app/data/repositories/mini_game/ws/yavarwee/yavarwee_web_socket_repository.dart';

import '../../../../data_sources/ws/web_socket_data_source.dart';
import '../../../../models/mini_game/ws/amount_dto.dart';
import '../../../../models/mini_game/ws/yavarwee_request.dart';

class YavarweeWebSocketRepositoryImpl implements YavarweeWebSocketRepository {
  final WebSocketDataSource _webSocketDataSource;

  YavarweeWebSocketRepositoryImpl(this._webSocketDataSource);

  @override
  void connect(String stageId) {
    _webSocketDataSource
        .connect("wss://echo.websocket.org" + "/yavarwee/$stageId");
  }

  @override
  void sendAmount(YavarweeRequest body) {
    _webSocketDataSource.sendMessage(body.toJson());
  }

  @override
  Stream<AmountDTO> listenForResponses() {
    return _webSocketDataSource.messages
        .map((event) => AmountDTO.fromJson(event));
  }

  @override
  void closeConnection() {
    _webSocketDataSource.close();
  }
}
