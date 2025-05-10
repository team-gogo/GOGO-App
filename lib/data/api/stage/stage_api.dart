import 'package:dio/dio.dart';
import 'package:gogo_app/data/models/stage/community/community_like_response.dart';
import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/create_stage/api/official_stage_create_request.dart';
import 'package:gogo_app/data/models/stage/create_stage/game.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/handle_stage/join_stage_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/match_notice_response.dart';
import 'package:gogo_app/data/models/stage/handle_stage/team_apply_request.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_maintainer_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_game_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_info_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_ranking_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_info_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_temp_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../models/common/team_response.dart';
import '../../models/stage/community/community_comment_request.dart';
import '../../models/stage/community/community_write_request.dart';
import '../../models/stage/community/search_board_response.dart';
import '../../models/stage/community/search_write_detail_response.dart';
import '../../models/stage/create_stage/api/fast_stage_create_request.dart';
import '../../models/stage/handle_stage/stage_confirm_request.dart';
import '../../models/stage/search_information/search_temp_point_response.dart';
import '../../models/stage/search_stage/search_match_query_string.dart';
import '../../models/stage/search_stage/search_match_response.dart';
import '../../models/stage/search_stage/search_my_point_response.dart';
import '../../models/stage/search_stage/search_my_team_response.dart';
import '../../models/stage/search_stage/search_stage_response.dart';
import '../../models/stage/search_stage/search_team_response.dart';

part 'stage_api.g.dart';

@RestApi()
abstract class StageApi {
  factory StageApi(Dio dio, {String baseUrl}) = _StageApi;

  // 사설 스테이지 생성 ✅
  @POST("/stage/fast")
  Future<void> createFastStage(
    @Body() FastStageCreateRequest body,
  );

  // 스테이지 확정 ✅
  @PATCH("/stage/confirm/{stage_id}")
  Future<void> confirmStage(
    @Path("stage_id") int stageId,
    @Body() StateConfirmRequest body,
  );

  // 스테이지 참여 ✅
  @POST("/stage/join/{stage_id}")
  Future<void> joinStage(
    @Path("stage_id") int stageId,
    @Body() JoinStageRequest body,
  );

  // 팀 신청 ✅
  @POST("/stage/team/{game_id}")
  Future<void> applyTeam(
    @Path("game_id") int gameId,
    @Body() TeamApplyRequest body,
  );

  // 경기에 출전하는 팀 조회 ✅
  @GET("/stage/team/{game_id}")
  Future<SearchTeamResponse> getTeams(
    @Path("game_id") int gameId,
  );

  // 경기에 신청된 팀 조회 ✅
  @GET("/stage/team/temp/{game_id}")
  Future<SearchTempTeamResponse> getTempTeams(
    @Path("game_id") int gameId,
  );

  // 팀 상세 조회 ✅
  @GET("/stage/team/info/{team_id}")
  Future<SearchTeamInfoResponse> getTeamDetail(
    @Path("team_id") int teamId,
  );

  // 스테이지에 등록된 경기 조회 ✅
  @GET("/stage/game/{stage_id}")
  Future<SearchGameResponse> getGame(
    @Path("stage_id") int stageId,
  );

  // 스테이지 전체 조회 ✅
  @GET("/stage")
  Future<SearchStageResponse> getAllStages();

  // 매치 상세 조회 ✅
  @GET("/stage/match/info/{match_id}")
  Future<SearchMatchInfoResponse> searchMatchInfo(
    @Path("match_id") int stageId,
  );

  // 매치 검색 ✅
  @GET("/stage/match/search/{stage_id}")
  Future<SearchMatchResponse> searchMatch(
    @Path("stage_id") int stageId,
    @Query('y') int y,
    @Query('m') int m,
    @Query('d') int d,
  );

  //포인트 랭킹 조회 ✅
  @GET('/stage/rank/{stage_id}')
  Future<SearchRankingResponse> searchRanking(
    @Path('stage_id') int stageId,
    @Query('page') int page,
    @Query('size') int size,
  );

  //매치 알림 토글하기 ✅
  @PATCH('/stage/match/notice/{match_id}')
  Future<MatchNoticeResponse> toggleMatchNotice(
    @Path('match_id') int matchId,
  );

  // 경기 게시판 글 작성 ✅
  @POST("/stage/community/{stage_id}")
  Future<void> createCommunityPost(
    @Path("stage_id") int stageId,
    @Body() CommunityWriteRequest body,
  );

  // 경기 게시판 조회 ✅
  @GET("/stage/community/{stage_id}")
  Future<SearchBoardResponse> getCommunityPosts(
    @Path("stage_id") int stageId,
    @Query('page') int page,
    @Query('size') int size,
    @Query('category') GameType? gameType,
    @Query('sort') SortType? sortType,
  );

  // 경기 게시글 상세 조회 ✅
  @GET("/stage/community/board/{board_id}")
  Future<SearchCommunityDetailResponse> getCommunityPostDetail(
    @Path("board_id") int boardId,
  );

  // 경기 게시글 좋아요 ✅
  @POST("/stage/community/{board_id}")
  Future<CommunityLikeResponse> likeCommunityPost(
    @Path("board_id") int boardId,
  );

  // 경기 게시글 댓글 작성 ✅
  @POST("/stage/community/comment/{board_id}")
  Future<CommunityLikeResponse> createCommunityComment(
    @Path("board_id") int boardId,
    @Body() CommunityCommentRequest body,
  );

  // 경기 게시물 댓글 좋아하기 ✅
  @POST('/stage/community/comment/like/{comment_id}')
  Future<CommunityLikeResponse> likeCommunityComment(
    @Path('comment_id') int commentId,
  );

  // 내가 스테이지 관리자인지 확인하기 ✅
  @GET('/stage/maintainer/me/{stage_id}')
  Future<SearchMaintainerResponse> getMaintainer(
    @Path('stage_id') int stageId,
  );

  // 내 임시 포인트 조회하기 ✅
  @GET('/stage/temp-point/me/{stage_id}')
  Future<SearchTempPointResponse> getTempPoint(
    @Path('stage_id') int stageId,
  );

  // 내 포인트 조회하기 ✅
  @GET('/stage/point/me/{stage_id}')
  Future<SearchMyPointResponse> getMyPoint(
    @Path('stage_id') int stageId,
  );

  // 내가 참여한 스테이지 조회하기 (마이페이지)✅
  @GET('/stage/me')
  Future<SearchMyTeamResponse> getMyTeam();

  // 내가 배팅한 매치 조회하기 (마이페이지) ✅
  @GET('/stage/match/me/{stage_id}')
  Future<SearchMatchResponse> getMyMatch(
    @Path('stage_id') int stageId,
  );
}
