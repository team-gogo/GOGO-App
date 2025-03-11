import '../../models/mini_game/active_game_response.dart';
import '../../models/mini_game/ticket_counts_response.dart';

abstract class MiniGameDataSource {
  Future<TicketCountsResponse> getTicketCount(String stageId);

  Future<ActiveGameResponse> getActiveGame(String stageId);
}
