import 'package:dio/dio.dart';
import 'package:gogo_app/data/models/mini_game/betting/coin_toss_request.dart';
import 'package:gogo_app/data/models/mini_game/betting/coin_toss_response.dart';
import 'package:gogo_app/data/models/mini_game/betting/plinko_response.dart';
import 'package:gogo_app/data/models/mini_game/betting/yavarwee_request.dart';
import 'package:gogo_app/data/models/mini_game/risk_level.dart';
import '../../api/mini_game/mini_game_api.dart';
import '../../models/mini_game/active_game_response.dart';
import '../../models/mini_game/bet_limit_response.dart';
import '../../models/mini_game/ticket_counts_response.dart';
import '../../util/execute_handle_api_call.dart';
import 'mini_game_data_source.dart';

class MiniGameDataSourceImpl implements MiniGameDataSource {
  final MiniGameApi _miniGameApi;

  MiniGameDataSourceImpl(Dio dio) : _miniGameApi = MiniGameApi(dio);

  @override
  Future<CoinTossResponse> getCoinTossBetting(
    int stageId,
    CoinTossRequest request,
  ) async {
    return await executeHandleApiCall(
        () => _miniGameApi.getCoinTossBetting(stageId, request));
  }

  @override
  Future<PlinkoResponse> getPlinkoBetting(
    int stageId,
    RiskLevel riskLevel,
  ) async {
    return await executeHandleApiCall(
        () => _miniGameApi.getPlinkoBetting(stageId, riskLevel));
  }

  @override
  Future<int> getYavarweeBetting(int stageId, YavarweeRequest body) async {
    return await executeHandleApiCall(
        () => _miniGameApi.getYavarweeBetting(stageId, body));
  }

  @override
  Future<TicketCountsResponse> getTicketCount(int stageId) async {
    return await executeHandleApiCall(
        () => _miniGameApi.getTicketCount(stageId));
  }

  @override
  Future<ActiveGameResponse> getActiveGame(int stageId) async {
    return await executeHandleApiCall(
        () => _miniGameApi.getActiveGame(stageId));
  }

  @override
  Future<BetLimitResponse> getBetLimit(int stageId) async {
    return await executeHandleApiCall(
        () => _miniGameApi.getBetLimit(stageId));
  }
}
