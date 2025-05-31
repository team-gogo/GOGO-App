import 'package:gogo_app/data/models/mini_game/betting/bet_limit_response.dart';
import 'package:gogo_app/data/models/mini_game/betting/coin_toss_response.dart';
import 'package:gogo_app/data/models/mini_game/betting/plinko_response.dart';
import 'package:gogo_app/data/models/mini_game/betting/yavarwee_request.dart';
import 'package:gogo_app/data/models/mini_game/risk_level.dart';
import '../../data_sources/mini_game/mini_game_data_source.dart';
import '../../models/mini_game/active_game_response.dart';
import '../../models/mini_game/ticket_counts_response.dart';
import 'mini_game_repository.dart';

class MiniGameRepositoryImpl implements MiniGameRepository {
  final MiniGameDataSource _miniGameDataSource;

  MiniGameRepositoryImpl(this._miniGameDataSource);

  @override
  Future<CoinTossResponse> getCoinTossBetting(int stageId, int amount) {
    return _miniGameDataSource.getCoinTossBetting(stageId, amount);
  }

  @override
  Future<PlinkoResponse> getPlinkoBetting(int stageId, RiskLevel riskLevel) {
    return _miniGameDataSource.getPlinkoBetting(stageId, riskLevel);
  }

  @override
  Future<int> getYavarweeBetting(int stageId, YavarweeRequest body) {
    return _miniGameDataSource.getYavarweeBetting(stageId, body);
  }

  @override
  Future<TicketCountsResponse> getTicketCount(int stageId) {
    return _miniGameDataSource.getTicketCount(stageId);
  }

  @override
  Future<ActiveGameResponse> getActiveGame(int stageId) {
    return _miniGameDataSource.getActiveGame(stageId);
  }

  @override
  Future<BetLimitResponse> getBetLimit(int stageId) {
    return _miniGameDataSource.getBetLimit(stageId);
  }
}
