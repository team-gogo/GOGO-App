import '../../data_sources/mini_game/mini_game_data_source.dart';
import '../../models/mini_game/active_game_response.dart';
import '../../models/mini_game/ticket_counts_response.dart';
import 'mini_game_repository.dart';

class MiniGameRepositoryImpl implements MiniGameRepository {
  final MiniGameDataSource _miniGameDataSource;

  MiniGameRepositoryImpl(this._miniGameDataSource);

  @override
  Future<TicketCountsResponse> getTicketCount(String stageId) {
    return _miniGameDataSource.getTicketCount(stageId);
  }

  @override
  Future<ActiveGameResponse> getActiveGame(String stageId) {
    return _miniGameDataSource.getActiveGame(stageId);
  }
}
