import 'package:dio/dio.dart';
import 'package:gogo_app/data/models/stage/create_stage/api/official_stage_create_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/team_apply_request.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/stage/community/community_write_request.dart';
import '../models/stage/community/search_board_response.dart';
import '../models/stage/community/search_write_detail_response.dart';
import '../models/stage/create_stage/api/fast_stage_create_request.dart';
import '../models/stage/handle_stage/stage_confirm_request.dart';
import '../models/stage/search_stage/search_match_query_string.dart';
import '../models/stage/search_stage/search_match_response.dart';
import '../models/stage/search_stage/stage_search_response.dart';
import '../models/stage/search_stage/team_search_response.dart';

part 'stage_api.g.dart';

@RestApi()
abstract class StageApi {
  factory StageApi(Dio dio, {String baseUrl}) = _StageApi;

  // 사설 스테이지 생성
  @POST("/fast")
  Future<void> createFastStage(@Body() FastStageCreateRequest body);

  // 공식 스테이지 생성
  @POST("/official")
  Future<void> createOfficialStage(@Body() OfficialStageCreateRequest body);

  // 스테이지 확정
  @PATCH("/confirm/{stage_id}")
  Future<void> confirmStage(
    @Path("stage_id") int stageId,
    @Body() StateConfirmRequest body,
  );

  // 스테이지 참여
  @POST("/join/{stage_id}")
  Future<void> joinStage(
    @Path("stage_id") int stageId,
    @Body() String body,
  );

  // 팀 신청
  @POST("/team/{game_id}")
  Future<void> applyTeam(
    @Path("game_id") int gameId,
    @Body() TeamApplyRequest body,
  );

  // 경기에 신청된 팀 조회
  @GET("/temp-team/{game_id}")
  Future<TeamSearchResponse> getTempTeams(@Path("game_id") int gameId);

  // 경기에 출전하는 팀 조회
  @GET("/team/{game_id}")
  Future<TeamSearchResponse> getGameTeams(@Path("game_id") int gameId);

  // 팀 상세 조회
  @GET("/team/{team_id}")
  Future<Team> getTeamDetail(@Path("team_id") int teamId);

  // 스테이지 전체 조회
  @GET("/")
  Future<StageSearchResponse> getAllStages();

  // 매치 검색
  @GET("/match/{stage_id}")
  Future<SearchMatchResponse> searchMatch(
      @Path("stage_id") SearchMatchQueryString stageId);

  // 경기 게시판 글 작성
  @POST("/community/{game_id}")
  Future<void> createCommunityPost(
    @Path("game_id") int gameId,
    @Body() CommunityWriteRequest body,
  );

  // 경기 게시판 조회
  @GET("/community/{game_id}")
  Future<SearchBoardResponse> getCommunityPosts(@Path("game_id") int gameId);

  // 경기 게시글 상세 조회
  @GET("/community/{board_id}")
  Future<SearchWriteDetailResponse> getCommunityPostDetail(
      @Path("board_id") int boardId);

  // 경기 게시글 좋아요
  @POST("/community/{board_id}")
  Future<void> likeCommunityPost(@Path("board_id") int boardId);

  // 경기 게시글 댓글 작성
  @POST("/community/comment/{board_id}")
  Future<void> createCommunityComment(
    @Path("board_id") int boardId,
    @Body() String body,
  );
}
