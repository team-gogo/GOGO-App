import 'package:dio/dio.dart';
import '../../api/mini_game/mini_game_api.dart';
import '../../models/mini_game/active_game_response.dart';
import '../../models/mini_game/ticket_counts_response.dart';
import '../../util/execute_handle_api_call.dart';
import 'mini_game_data_source.dart';

class MiniGameDataSourceImpl implements MiniGameDataSource {
  final MiniGameApi _miniGameApi;

  MiniGameDataSourceImpl(Dio dio) : _miniGameApi = MiniGameApi(dio);

  @override
  Future<TicketCountsResponse> getTicketCount(String stageId) async {
    return await executeHandleApiCall(
        () => _miniGameApi.getTicketCount(stageId));
  }

  @override
  Future<ActiveGameResponse> getActiveGame(String stageId) async {
    return await executeHandleApiCall(
        () => _miniGameApi.getActiveGame(stageId));
  }
}
