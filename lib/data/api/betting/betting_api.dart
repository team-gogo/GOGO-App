import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../models/betting/request/betting_match_request.dart';
import '../../models/betting/request/match_settle_request.dart';

part 'betting_api.g.dart';

@RestApi()
abstract class BettingApi {
  factory BettingApi(Dio dio, {String baseUrl}) = _BettingApi;
  
  @POST('/betting/{match_id}')
  Future<void> bettingMatch(
      @Path('match_id') int matchId,
      @Body() BettingMatchRequest body);
  
  @POST('/betting/batch/{match_id}')
  Future<void> matchSettle(
      @Path('match_id') int matchId,
      @Body() MatchSettleRequest body);
  
  @POST('/betting/batch/cancel/{match_id}')
  Future<void> cancelMatch(
      @Path('match_id') int matchId);
}