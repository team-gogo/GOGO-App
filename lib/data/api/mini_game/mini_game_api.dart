import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gogo_app/data/models/mini_game/betting/plinko_response.dart';
import 'package:gogo_app/data/models/mini_game/risk_level.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../models/mini_game/active_game_response.dart';
import '../../models/mini_game/betting/coin_toss_response.dart';
import '../../models/mini_game/betting/yavarwee_request.dart';
import '../../models/mini_game/betting/yavarwee_bet_response.dart';
import '../../models/mini_game/ticket_counts_response.dart';

part 'mini_game_api.g.dart';

@RestApi()
abstract class MiniGameApi {
  factory MiniGameApi(Dio dio, {String baseUrl}) = _MiniGameApi;

  @GET("/minigame/plinko/{stage_id}")
  Future<PlinkoResponse> getPlinkoBetting(
    @Path("stage_id") int stageId,
    @Body() RiskLevel riskLevel,
  );

  @GET("/minigame/coin-toss/{stage_id}")
  Future<CoinTossResponse> getCoinTossBetting(
    @Path("stage_id") int stageId,
    @Body() int amount,
  );

  @GET("/minigame/yavarwee/{stage_id}")
  Future<int> getYavarweeBetting(
    @Path("stage_id") int stageId,
    @Body() YavarweeRequest body,
  );

  @POST("/minigame/yavarwee/bet/{stage_id}")
  Future<YavarweeBetResponse> placeYavarweeBet(
    @Path("stage_id") int stageId,
    @Body() Map<String, dynamic> body,
  );

  @GET("/minigame/ticket/{stage_id}")
  Future<TicketCountsResponse> getTicketCount(@Path("stage_id") int stageId);

  @GET("/minigame/active-game/{stage_id}")
  Future<ActiveGameResponse> getActiveGame(@Path("stage_id") int stageId);
}
