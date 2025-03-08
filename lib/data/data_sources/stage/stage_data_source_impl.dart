import 'package:dio/dio.dart';
import 'package:gogo_app/data/api/stage_api.dart';
import 'package:gogo_app/data/util/execute_handle_api_call.dart';
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

import 'stage_data_source.dart';

class StageDataSourceImpl implements StageDataSource {
  final StageApi _stageApi;

  StageDataSourceImpl(Dio dio) : _stageApi = StageApi(dio);

  @override
  Future<void> createFastStage(FastStageCreateRequest body) async {
    return await executeHandleApiCall(() => _stageApi.createFastStage(body));
  }

  @override
  Future<void> createOfficialStage(OfficialStageCreateRequest body) async {
    return await executeHandleApiCall(
        () => _stageApi.createOfficialStage(body));
  }

  @override
  Future<void> confirmStage(int stageId, StateConfirmRequest body) async {
    return await executeHandleApiCall(
        () => _stageApi.confirmStage(stageId, body));
  }

  @override
  Future<void> joinStage(int stageId, String body) async {
    return await executeHandleApiCall(() => _stageApi.joinStage(stageId, body));
  }

  @override
  Future<void> applyTeam(int gameId, TeamApplyRequest body) async {
    return await executeHandleApiCall(() => _stageApi.applyTeam(gameId, body));
  }

  @override
  Future<TeamSearchResponse> getTempTeams(int gameId) async {
    return await executeHandleApiCall(() => _stageApi.getTempTeams(gameId));
  }

  @override
  Future<TeamSearchResponse> getGameTeams(int gameId) async {
    return await executeHandleApiCall(() => _stageApi.getGameTeams(gameId));
  }

  @override
  Future<Team> getTeamDetail(int teamId) async {
    return await executeHandleApiCall(() => _stageApi.getTeamDetail(teamId));
  }

  @override
  Future<StageSearchResponse> getAllStages() async {
    return await executeHandleApiCall(() => _stageApi.getAllStages());
  }

  @override
  Future<SearchMatchResponse> searchMatch(
      SearchMatchQueryString stageId) async {
    return await executeHandleApiCall(() => _stageApi.searchMatch(stageId));
  }

  @override
  Future<void> createCommunityPost(
      int gameId, CommunityWriteRequest body) async {
    return await executeHandleApiCall(
        () => _stageApi.createCommunityPost(gameId, body));
  }

  @override
  Future<SearchBoardResponse> getCommunityPosts(int gameId) async {
    return await executeHandleApiCall(
        () => _stageApi.getCommunityPosts(gameId));
  }

  @override
  Future<SearchWriteDetailResponse> getCommunityPostDetail(int boardId) async {
    return await executeHandleApiCall(
        () => _stageApi.getCommunityPostDetail(boardId));
  }

  @override
  Future<void> likeCommunityPost(int boardId) async {
    return await executeHandleApiCall(
        () => _stageApi.likeCommunityPost(boardId));
  }

  @override
  Future<void> createCommunityComment(int boardId, String body) async {
    return await executeHandleApiCall(
        () => _stageApi.createCommunityComment(boardId, body));
  }
}
