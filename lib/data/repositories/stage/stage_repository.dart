import 'package:gogo_app/data/models/stage/create_stage/api/official_stage_create_request.dart';
import 'package:gogo_app/data/models/stage/create_stage/api/fast_stage_create_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/stage_confirm_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/team_apply_request.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_query_string.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_response.dart';
import 'package:gogo_app/data/models/stage/community/community_write_request.dart';
import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:gogo_app/data/models/stage/community/search_write_detail_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_temp_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_game_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_info_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_info_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_ranking_response.dart';
import 'package:gogo_app/data/models/stage/handle_stage/match_notice_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_maintainer_response.dart';
import 'package:gogo_app/data/models/stage/search_information/search_temp_point_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_my_point_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_my_team_response.dart';
import 'package:gogo_app/data/models/stage/community/community_like_response.dart';
import 'package:gogo_app/data/models/stage/community/community_comment_request.dart';
import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';

import '../../models/stage/handle_stage/join_stage_request.dart';

abstract class StageRepository {
  Future<void> createFastStage(FastStageCreateRequest body);

  Future<void> createOfficialStage(OfficialStageCreateRequest body);

  Future<void> confirmStage(int stageId, StateConfirmRequest body);

  Future<void> joinStage(int stageId, JoinStageRequest body);

  Future<void> applyTeam(int gameId, TeamApplyRequest body);

  Future<SearchTeamResponse> getTeams(int gameId);

  Future<SearchTempTeamResponse> getTempTeams(int gameId);

  Future<SearchTeamInfoResponse> getTeamDetail(int teamId);

  Future<SearchGameResponse> getGame(int stageId);

  Future<SearchStageResponse> getAllStages();

  Future<SearchMatchInfoResponse> searchMatchInfo(int matchId);

  Future<SearchMatchResponse> searchMatch(int stageId, int y, int m, int d);

  Future<SearchRankingResponse> searchRanking(int stageId, int page, int size);

  Future<MatchNoticeResponse> toggleMatchNotice(int matchId);

  Future<void> createCommunityPost(int stageId, CommunityWriteRequest body);

  Future<SearchBoardResponse> getCommunityPosts(
      int stageId, int page, int size, GameType? gameType, SortType? sortType);

  Future<SearchCommunityDetailResponse> getCommunityPostDetail(int boardId);

  Future<CommunityLikeResponse> likeCommunityPost(int boardId);

  Future<CommunityLikeResponse> createCommunityComment(
      int boardId, CommunityCommentRequest body);

  Future<CommunityLikeResponse> likeCommunityComment(int commentId);

  Future<SearchMaintainerResponse> getMaintainer(int stageId);

  Future<SearchTempPointResponse> getTempPoint(int stageId);

  Future<SearchMyPointResponse> getMyPoint(int stageId);

  Future<SearchMyTeamResponse> getMyTeam();

  Future<SearchMatchResponse> getMyMatch(int stageId);
}
