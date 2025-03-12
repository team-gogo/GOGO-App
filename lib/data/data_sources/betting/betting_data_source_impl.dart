import 'package:dio/dio.dart';
import 'package:gogo_app/data/api/betting/betting_api.dart';
import 'package:gogo_app/data/data_sources/betting/betting_data_source.dart';
import 'package:gogo_app/data/models/betting/request/betting_match_request.dart';
import 'package:gogo_app/data/models/betting/request/match_settle_request.dart';

import '../../util/execute_handle_api_call.dart';

class BettingDataSourceImpl implements BettingDataSource {
  final BettingApi _bettingApi;

  BettingDataSourceImpl(Dio dio) : _bettingApi = BettingApi(dio);

  @override
  Future<void> bettingMatch(int matchId, BettingMatchRequest body) async {
    return await executeHandleApiCall(() => _bettingApi.bettingMatch(matchId, body));
  }

  @override
  Future<void> cancelBettingMatch(int matchId) async {
    return await executeHandleApiCall(() => _bettingApi.cancelMatch(matchId));
  }

  @override
  Future<void> matchSettle(int matchId, MatchSettleRequest body) async {
    return await executeHandleApiCall(() => _bettingApi.matchSettle(matchId, body));
  }

}