import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/mini_game/active_game_response.dart';
import '../models/mini_game/ticket_counts_response.dart';

part 'mini_game_api.g.dart';

@RestApi()
abstract class MiniGameApi {
  factory MiniGameApi(Dio dio, {String baseUrl}) = _MiniGameApi;

  @GET("/minigame/ticket/{stage_id}")
  Future<TicketCountsResponse> getTicketCount(@Path("stage_id") String stageId);

  @GET("/minigame/active-game/{stage_id}")
  Future<ActiveGameResponse> getActiveGame(@Path("stage_id") String stageId);
}
