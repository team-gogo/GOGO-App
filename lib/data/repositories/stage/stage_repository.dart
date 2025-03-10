import 'package:gogo_app/data/models/stage/create_stage/api/official_stage_create_request.dart';
import 'package:gogo_app/data/models/stage/create_stage/api/fast_stage_create_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/stage_confirm_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/team_apply_request.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_query_string.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_match_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/stage_search_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/team_search_response.dart';
import 'package:gogo_app/data/models/stage/community/community_write_request.dart';
import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:gogo_app/data/models/stage/community/search_write_detail_response.dart';

abstract class StageRepository {
  Future<void> createFastStage(FastStageCreateRequest body);
  Future<void> createOfficialStage(OfficialStageCreateRequest body);
  Future<void> confirmStage(int stageId, StateConfirmRequest body);
  Future<void> joinStage(int stageId, String body);
  Future<void> applyTeam(int gameId, TeamApplyRequest body);
  Future<TeamSearchResponse> getTempTeams(int gameId);
  Future<TeamSearchResponse> getGameTeams(int gameId);
  Future<Team> getTeamDetail(int teamId);
  Future<StageSearchResponse> getAllStages();
  Future<SearchMatchResponse> searchMatch(SearchMatchQueryString stageId);
  Future<void> createCommunityPost(int gameId, CommunityWriteRequest body);
  Future<SearchBoardResponse> getCommunityPosts(int gameId);
  Future<SearchWriteDetailResponse> getCommunityPostDetail(int boardId);
  Future<void> likeCommunityPost(int boardId);
  Future<void> createCommunityComment(int boardId, String body);
}
