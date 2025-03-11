import 'package:gogo_app/data/models/betting/request/betting_match_request.dart';
import 'package:gogo_app/data/models/betting/request/match_settle_request.dart';

abstract class BettingDataSource {
  Future<void> bettingMatch(int matchId, BettingMatchRequest body);
  Future<void> matchSettle(int matchId, MatchSettleRequest body);
  Future<void> cancelBettingMatch(int matchId);
}