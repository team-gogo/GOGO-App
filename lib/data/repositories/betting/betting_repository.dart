import '../../models/betting/request/betting_match_request.dart';
import '../../models/betting/request/match_settle_request.dart';

abstract class BettingRepository {
  Future<void> bettingMatch(int matchId, BettingMatchRequest body);
  Future<void> matchSettle(int matchId, MatchSettleRequest body);
  Future<void> cancelBettingMatch(int matchId);
}