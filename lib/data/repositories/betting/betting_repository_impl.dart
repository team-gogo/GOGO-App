import 'package:gogo_app/data/data_sources/betting/betting_data_source.dart';
import 'package:gogo_app/data/models/betting/request/betting_match_request.dart';
import 'package:gogo_app/data/models/betting/request/match_settle_request.dart';
import 'package:gogo_app/data/repositories/betting/betting_repository.dart';

class BettingRepositoryImpl implements BettingRepository {
  final BettingDataSource _bettingDataSource;

  BettingRepositoryImpl(this._bettingDataSource);

  @override
  Future<void> bettingMatch(int matchId, BettingMatchRequest body) {
    return _bettingDataSource.bettingMatch(matchId, body);
  }

  @override
  Future<void> cancelBettingMatch(int matchId) {
    return _bettingDataSource.cancelBettingMatch(matchId);
  }

  @override
  Future<void> matchSettle(int matchId, MatchSettleRequest body) {
    return _bettingDataSource.matchSettle(matchId, body);
  }
}