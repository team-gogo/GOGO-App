import '../../models/mini_game/active_game_response.dart';
import '../../models/mini_game/betting/coin_toss_response.dart';
import '../../models/mini_game/betting/plinko_response.dart';
import '../../models/mini_game/betting/yavarwee_request.dart';
import '../../models/mini_game/risk_level.dart';
import '../../models/mini_game/ticket_counts_response.dart';

abstract class MiniGameRepository {
  Future<PlinkoResponse> getPlinkoBetting(
    int stageId,
    RiskLevel riskLevel,
  );

  Future<CoinTossResponse> getCoinTossBetting(
    int stageId,
    int amount,
  );

  Future<int> getYavarweeBetting(
    int stageId,
    YavarweeRequest body,
  );

  Future<TicketCountsResponse> getTicketCount(int stageId);

  Future<ActiveGameResponse> getActiveGame(int stageId);
}
