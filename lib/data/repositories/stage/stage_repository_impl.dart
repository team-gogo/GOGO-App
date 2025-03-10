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
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';

import '../../data_sources/stage/stage_data_source.dart';

class StageRepositoryImpl implements StageRepository {
  final StageDataSource _stageDataSource;

  StageRepositoryImpl(this._stageDataSource);

  @override
  Future<void> createFastStage(FastStageCreateRequest body) {
    return _stageDataSource.createFastStage(body);
  }

  @override
  Future<void> createOfficialStage(OfficialStageCreateRequest body) {
    return _stageDataSource.createOfficialStage(body);
  }

  @override
  Future<void> confirmStage(int stageId, StateConfirmRequest body) {
    return _stageDataSource.confirmStage(stageId, body);
  }

  @override
  Future<void> joinStage(int stageId, String body) {
    return _stageDataSource.joinStage(stageId, body);
  }

  @override
  Future<void> applyTeam(int gameId, TeamApplyRequest body) {
    return _stageDataSource.applyTeam(gameId, body);
  }

  @override
  Future<TeamSearchResponse> getTempTeams(int gameId) {
    return _stageDataSource.getTempTeams(gameId);
  }

  @override
  Future<TeamSearchResponse> getGameTeams(int gameId) {
    return _stageDataSource.getGameTeams(gameId);
  }

  @override
  Future<Team> getTeamDetail(int teamId) {
    return _stageDataSource.getTeamDetail(teamId);
  }

  @override
  Future<StageSearchResponse> getAllStages() {
    return _stageDataSource.getAllStages();
  }

  @override
  Future<SearchMatchResponse> searchMatch(SearchMatchQueryString stageId) {
    return _stageDataSource.searchMatch(stageId);
  }

  @override
  Future<void> createCommunityPost(int gameId, CommunityWriteRequest body) {
    return _stageDataSource.createCommunityPost(gameId, body);
  }

  @override
  Future<SearchBoardResponse> getCommunityPosts(int gameId) {
    return _stageDataSource.getCommunityPosts(gameId);
  }

  @override
  Future<SearchWriteDetailResponse> getCommunityPostDetail(int boardId) {
    return _stageDataSource.getCommunityPostDetail(boardId);
  }

  @override
  Future<void> likeCommunityPost(int boardId) {
    return _stageDataSource.likeCommunityPost(boardId);
  }

  @override
  Future<void> createCommunityComment(int boardId, String body) {
    return _stageDataSource.createCommunityComment(boardId, body);
  }
}
